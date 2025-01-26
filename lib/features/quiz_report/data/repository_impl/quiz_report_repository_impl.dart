import 'package:dio/dio.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_report_model.dart';

class QuizReportDataSource {
  final Dio dio;

  QuizReportDataSource({required this.dio});

  Future<List<QuizResultReportModel>> getQuizResultList() async {
    final userId = await SharedPrefs.getUserId();
    var request = await dio.get("/api/quiz/results/report?userId=$userId");
    List<dynamic> dataList = request.data as List;
    List<QuizResultReportModel> quizResultList =
        dataList.map((data) => QuizResultReportModel.fromJson(data)).toList();
    return quizResultList;
  }
}
