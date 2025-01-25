import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<QuizModel>>> getQuizList();
  Future<Either<Failure, List<QuizQuestionModel>>> getQuizQuestions({required String quizId});
}
