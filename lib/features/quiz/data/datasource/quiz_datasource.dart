import 'package:dio/dio.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/quiz/domain/model/quiz_ans_send_model/quiz_user_ans_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_result_model/quiz_result_model.dart';

class QuizDataSource {
  final Dio dio;

  QuizDataSource({required this.dio});

  Future<List<QuizModel>> getQuiz() async {
    var request = await dio.get("api/quiz/getAllQuiz");
    List<dynamic> dataList = request.data as List;
    List<QuizModel> quizList =
        dataList.map((data) => QuizModel.fromJson(data)).toList();
    return quizList;
  }

  Future<List<QuizQuestionModel>> getQuizQuestions(
      {required String quizId}) async {
    var request = await dio.get("api/quiz/getQuizQuestions/$quizId");
    List<dynamic> dataList = request.data as List<dynamic>;
    List<QuizQuestionModel> quizQuestionList =
        dataList.map((data) => QuizQuestionModel.fromJson(data)).toList();
    return quizQuestionList;
  }

  Future<QuizResultModel> getQuizResult(
      {required int quizId,
      required List<UserAnswer> quizAnsSendList}) async {
    final userId = await SharedPrefs.getUserId();
    Map<String, dynamic> queryParameter = {
      "userId": userId,
      "quizId": quizId,
      "userAnswers": quizAnsSendList
    };
    var request =
        await dio.post("/api/quiz/results/calculate", data: queryParameter);

    QuizResultModel quizResultModel = QuizResultModel.fromJson(request.data);
    return quizResultModel;
  }
}
