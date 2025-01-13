import 'package:dio/dio.dart';
import 'package:game_app/core/storage/shared_prefs.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  TokenInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Skip adding token for login and other specific routes
      if (options.path != 'login') {
        final token = await SharedPrefs.getToken(); // Properly await the Future
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }
      handler.next(options);
    } catch (e) {
      handler.reject(DioError(requestOptions: options, error: 'Failed to retrieve token'));
    }
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final username = await SharedPrefs.getLoginUserName(); // Properly await the Future
        final password = await SharedPrefs.getLoginUserPass(); // Properly await the Future

        // Ensure both username and password are retrieved correctly
        if (username != null && password != null) {
          // Refresh the token
          final newTokenResponse = await dio.post("login", data: {
            "username": username,
            "password": password
          });

          if (newTokenResponse.statusCode == 200) {
            final newToken = newTokenResponse;
            await SharedPrefs.saveToken(newToken.toString());

            // Retry the failed request with the new token
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            final response = await dio.request(
              err.requestOptions.path,
              options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
              ),
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            _isRefreshing = false;
            return handler.resolve(response);
          }
        }

        _isRefreshing = false;
        return handler.reject(err);
      } catch (e) {
        _isRefreshing = false;
        return handler.next(err);
      }
    }
    handler.next(err);
  }
}
