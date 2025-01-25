import 'package:dio/dio.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';

class UserRemoteDataSource{

  final Dio dio;

  UserRemoteDataSource({required this.dio});

Future<UserModel>getUser(String userName) async{

  String? userId=await SharedPrefs.getUserId();
  print("userId${userId}");
  var request=await dio.get("api/user/$userId");

  return UserModel.fromJson(request.data);
}
}