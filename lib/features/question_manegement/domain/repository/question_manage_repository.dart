import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/core/model/question_detail_model.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

abstract class QuestionManageRepository {
  Future<Either<Failure, List<CategoryModel>>> getQuestionCategory();

  Future<Either<Failure, List<QuestionTypeModel>>> getQuestionType();

  Future<Either<Failure, List<DifficultyModel>>> getQuestionDifficulty();

  Future<Either<Failure, QuestionDetailModel>> submitQuestion(
      {required String question,
      required String correctAnswer,
      required String selectedQuestionType,
      required List<String> options,
      required String selectedQuestionCategory,
      required String selectedDifficultyId});

  Future<Either<Failure, QuestionDetailModel>> editQuestion(
      {required String question,
        required String correctAnswer,
        required String selectedQuestionType,
        required List<Option> options,
        required String selectedQuestionCategory,
        required String selectedDifficultyId,required int questionId});
  Future<Either<Failure, List<QuizQuestionModel>>> getAllQuestions();
  Future<Either<Failure, int>> deleteQuestion({required int questionId});
}
