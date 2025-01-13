import 'package:dio/dio.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';

class UserRemoteDataSource{

  final Dio dio;

  UserRemoteDataSource({required this.dio});

Future<UserModel>getUser(String userName) async{

  var request=await dio.get("getUserDetails/$userName");

  return UserModel.fromJson(request.data);
}
}