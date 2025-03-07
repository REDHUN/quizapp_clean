import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/core/model/question_detail_model.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/features/question_manegement/data/datasource/question_manage_datasource.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';
import 'package:game_app/features/question_manegement/domain/repository/question_manage_repository.dart';

class QuestionManageRepositoryImpl implements QuestionManageRepository {
  final QuestionManageDatasource questionManageDatasource;

  QuestionManageRepositoryImpl({required this.questionManageDatasource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getQuestionCategory() async {
    try {
      final request = await questionManageDatasource.getQuestionCategory();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(
          AuthFailure(message: " Get Question Category Failure"));
    }
  }

  @override
  Future<Either<Failure, List<DifficultyModel>>> getQuestionDifficulty() async {
    try {
      final request = await questionManageDatasource.getQuestionDifficulty();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(
          AuthFailure(message: " Get Question Difficulty Failure"));
    }
  }

  @override
  Future<Either<Failure, List<QuestionTypeModel>>> getQuestionType() async {
    try {
      final request = await questionManageDatasource.getQuestionType();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Question Type Failure"));
    }
  }

  @override
  Future<Either<Failure, QuestionDetailModel>> submitQuestion(
      {required String question,
      required String correctAnswer,
      required String selectedQuestionType,
      required List<String> options,
      required String selectedQuestionCategory,
      required String selectedDifficultyId}) async {
    try {
      final request = await questionManageDatasource.submitQuestion(
          question: question,
          correctAnswer: correctAnswer,
          options: options,
          selectedDifficultyId: selectedDifficultyId,
          selectedQuestionCategory: selectedQuestionCategory,
          selectedQuestionType: selectedQuestionType);

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Question Type Failure"));
    }
  }

  @override
  Future<Either<Failure, List<QuizQuestionModel>>> getAllQuestions() async{
    try {
      final request = await questionManageDatasource.getAllQuestions();


      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Questions  Failure"));
  }
}

  @override
  Future<Either<Failure, QuestionDetailModel>> editQuestion({required String question, required String correctAnswer, required String selectedQuestionType, required List<Option> options, required String selectedQuestionCategory, required String selectedDifficultyId, required int questionId}) async{
    try {
      final request = await questionManageDatasource.editQuestion(
          question: question,
          correctAnswer: correctAnswer,
          options: options,
          selectedDifficultyId: selectedDifficultyId,
          selectedQuestionCategory: selectedQuestionCategory,
          selectedQuestionType: selectedQuestionType,questionId: questionId);

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Question Type Failure"));
    }
  }

  @override
  Future<Either<Failure, int>> deleteQuestion({required int questionId}) async{
    try {
      final request = await questionManageDatasource.deleteQuestion(questionId: questionId);
      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Delete Question Failure"));
    }
  }

  @override
  Future<Either<Failure, List<QuizQuestionModel>>> getFilteredQuestions({String? questionCategoryId, String? questionTypeId, String? questionDifficultyId}) async{
    try {
      final request = await questionManageDatasource.getFilteredQuestions(questionTypeId: questionTypeId,questionDifficultyId: questionDifficultyId,questionCategoryId: questionCategoryId,);


      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Questions  Failure"));
    }
  }
}