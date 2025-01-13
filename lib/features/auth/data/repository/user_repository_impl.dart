import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';
import 'package:game_app/features/auth/domain/repository/user_respository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, UserModel>> getUser({required String userName}) async{

    try{

      var response= await userRemoteDataSource.getUser(userName);

      return Either.right(response);
    }
    on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(UserDetailsFailure(message: "User Details failure"));
    }
  }


}