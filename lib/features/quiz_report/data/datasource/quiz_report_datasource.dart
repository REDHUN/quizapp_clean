import 'package:dio/dio.dart';
import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/quiz_report/data/repository_impl/quiz_report_repository_impl.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_report_model.dart';
import 'package:game_app/features/quiz_report/domain/repository/quiz_report_repository.dart';

class QuizReportRepositoryImpl implements QuizReportRepository {
  final QuizReportDataSource quizReportDataSource;

  QuizReportRepositoryImpl({required this.quizReportDataSource});

  @override
  Future<Either<Failure, List<QuizResultReportModel>>>
      getQuizResultList() async {
    try {
      final request = await quizReportDataSource.getQuizResultList();

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(DioErrorHandler.handleDioError(e));
    } on Exception catch (e) {
      return Either.left(AuthFailure(message: "Quiz Result Get Failure"));
    }
  }
}
