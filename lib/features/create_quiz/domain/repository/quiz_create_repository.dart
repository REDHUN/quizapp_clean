import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';

abstract class CreateQuizRepository {
  Future<Either<Failure, int>> createQuiz({required int noOfQuestions,required String quizName,required String quizDescription});
}
