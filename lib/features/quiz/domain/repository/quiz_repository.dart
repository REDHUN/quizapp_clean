import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<QuizModel>>> getQuizList();
}
