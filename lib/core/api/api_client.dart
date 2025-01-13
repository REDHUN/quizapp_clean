import 'package:dio/dio.dart';
import 'package:game_app/core/api/api_confilg.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:game_app/core/storage/shared_prefs.dart';

import 'interceptors/token_interceptor.dart'; // Assuming you store your token in shared preferences

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.options.baseUrl = ApiConfig.baseUrl;

    if (tokenInterceptor) {
      dio.interceptors.add(TokenInterceptor(dio: dio));
    }

    dio.interceptors.add(
      PrettyDioLogger(
        responseHeader: true,
        responseBody: true,
        requestHeader: true,
        requestBody: true,
        request: true,
        compact: false,
      ),
    );

    return dio;
  }
}
