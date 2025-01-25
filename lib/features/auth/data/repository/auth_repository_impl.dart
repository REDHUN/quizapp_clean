import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:game_app/features/auth/domain/model/auth/auth_model.dart';
import 'package:game_app/features/auth/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, AuthModel>> loginWithUserPassword(
      {required String username, required password}) async {
    try {
    AuthModel request = await authRemoteDataSource.loginWithUserPassword(
          username: username, password: password);
     await SharedPrefs.saveToken(request.token??"");
      await SharedPrefs.saveLoginUserName(username);
      await SharedPrefs.saveLoginUserPass(password);
      await SharedPrefs.saveUserId(request.userId??"");

      print("user iddddd ${request.userId??""}");

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Auth failure"));
    }
  }
}
