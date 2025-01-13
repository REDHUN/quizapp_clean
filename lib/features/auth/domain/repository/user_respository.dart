import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';

abstract class UserRepository{

  Future<Either<Failure,UserModel>> getUser({required String userName});
}