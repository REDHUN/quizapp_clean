import 'package:dio/dio.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';

class UserRemoteDataSource{

  final Dio dio;

  UserRemoteDataSource({required this.dio});

Future<UserModel>getUser() async{

  var request=await dio.get("api/auth/getUserDetails");

  return UserModel.fromJson(request.data);
}
}