import 'package:dio/dio.dart';
import 'package:game_app/features/auth/domain/model/auth/auth_model.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';

class AuthRemoteDataSource{

  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<AuthModel> loginWithUserPassword({required String username,required String password}) async{

    var request =await dio.post("api/auth/login",data: {
      "username" : username,
      "password": password
    });

    return AuthModel.fromJson(request.data);
  }

}