import 'package:dio/dio.dart';

class CreateQuizDataSource {
  final Dio dio;

  CreateQuizDataSource({required this.dio});

  Future<int> createQuiz(
      {required String title,
      required description,
      required int noOfQuestions}) async {
    Map<String, dynamic> queryParameter = {
      "title": title,
      "description": description,
      "numberOfQuestions": noOfQuestions
    };

    var request =
        await dio.post("/api/quiz/createQuiz",data: queryParameter);
    final data = request.data;

    return data;
  }
}
