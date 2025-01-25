import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/quiz/data/datasource/quiz_datasource.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/features/quiz/domain/repository/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource quizDataSource;

  QuizRepositoryImpl({required this.quizDataSource});
  @override
  Future<Either<Failure, List<QuizModel>>> getQuizList() async{

    try {
      final request = await quizDataSource.getQuiz(
        );


      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Quiz Get Failure"));
    }
  }

  @override
  Future<Either<Failure, List<QuizQuestionModel>>> getQuizQuestions({required String quizId}) async{
    try {
      final request = await quizDataSource.getQuizQuestions(quizId: quizId);


      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Quiz Get Failure"));
    }
  }
  }


