import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/create_quiz/data/datasource/create_quiz_datasource.dart';
import 'package:game_app/features/create_quiz/domain/repository/quiz_create_repository.dart';

class CreateQuizRepositoryImpl implements CreateQuizRepository{
  final CreateQuizDataSource  createQuizDataSource;
  CreateQuizRepositoryImpl({required this.createQuizDataSource});
  @override
  Future<Either<Failure, int>> createQuiz({required int noOfQuestions, required String quizName, required String quizDescription})async {



    try {
      final request = await  createQuizDataSource.createQuiz(title: quizName, description: quizDescription, noOfQuestions: noOfQuestions);

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Quiz Create Failure"));
    }
  }
}