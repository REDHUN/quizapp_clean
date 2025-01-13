import 'package:dio/dio.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model.dart';

class QuizDataSource {
  final Dio dio;

  QuizDataSource({required this.dio});

  Future<List<QuizModel>> getQuiz() async {
 var  request = await dio.get("quiz/getAllQuiz");
   List<dynamic> dataList=request.data as List;
   List<QuizModel> quizList = dataList.map((data) => QuizModel.fromJson(data)).toList();
    return quizList;
  }
}
