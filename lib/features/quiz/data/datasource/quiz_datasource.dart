import 'package:dio/dio.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';

class QuizDataSource {
  final Dio dio;

  QuizDataSource({required this.dio});

  Future<List<QuizModel>> getQuiz() async {
 var  request = await dio.get("api/quiz/getAllQuiz");
   List<dynamic> dataList=request.data as List;
   List<QuizModel> quizList = dataList.map((data) => QuizModel.fromJson(data)).toList();
    return quizList;
  }
  Future<List<QuizQuestionModel>> getQuizQuestions({required String quizId}) async {
    var  request = await dio.get("api/quiz/getQuizQuestions/$quizId");
    List<dynamic> dataList = request.data as List<dynamic>;
    List<QuizQuestionModel> quizQuestionList = dataList.map((data) => QuizQuestionModel.fromJson(data)).toList();
    return quizQuestionList;
  }
}
