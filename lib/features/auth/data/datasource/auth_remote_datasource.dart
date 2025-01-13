import 'package:dio/dio.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';

class AuthRemoteDataSource{

  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<String> loginWithUserPassword({required String username,required String password}) async{

    var request =await dio.post("login",data: {
      "username" : username,
      "password": password
    });

    return request.data;
  }

}