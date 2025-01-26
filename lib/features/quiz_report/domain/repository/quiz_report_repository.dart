import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_report_model.dart';

abstract class QuizReportRepository {
  Future<Either<Failure, List<QuizResultReportModel>>> getQuizResultList();

}