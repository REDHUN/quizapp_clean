import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/core/model/question_type_model/question_type_model.dart';
import 'package:game_app/features/question_attributes_manage/data/datasource/question_attribute_datasource.dart';
import 'package:game_app/features/question_attributes_manage/domain/repository/question_attribute_repository.dart';

class QuestionAttributeRepositoryImpl implements QuestionAttributeRepository {
  final QuestionAttributeDatasource questionCategoryDatasource;

  QuestionAttributeRepositoryImpl({required this.questionCategoryDatasource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getQuestionCategory() async {
    try {
      final request = await questionCategoryDatasource.getQuestionCategory();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(
          AuthFailure(message: " Get Question Category  Failure"));
    }
  }

  @override
  Future<Either<Failure, List<DifficultyModel>>> getQuestionDifficulty() async {
    try {
      final request = await questionCategoryDatasource.getQuestionDifficulty();

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
      final request = await questionCategoryDatasource.getQuestionType();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: " Get Question Type Failure"));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> addQuestionCategory(
      {required String categoryName,  int  ? categoryId}) async {
    try {
      final request = await questionCategoryDatasource.addQuestionCategory(
          categoryName: categoryName, categoryId: categoryId);

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Add question category error"));
    }
  }
}
