import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';

abstract class AuthRepository{

  Future<Either<Failure,String>>loginWithUserPassword({required String username,required password});
}