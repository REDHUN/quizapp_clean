import 'package:dio/dio.dart';
import 'package:game_app/core/model/question_detail_model.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

class QuestionManageDatasource {
  final Dio dio;

  QuestionManageDatasource({required this.dio});

  Future<List<CategoryModel>> getQuestionCategory() async {
    var request = await dio.get("api/questions/getQuestionCategory");
    List<dynamic> dataList = request.data as List;
    List<CategoryModel> categoryList =
        dataList.map((data) => CategoryModel.fromJson(data)).toList();
    return categoryList;
  }

  Future<List<QuestionTypeModel>> getQuestionType() async {
    var request = await dio.get("api/questions/getQuestionType");
    List<dynamic> dataList = request.data as List;
    List<QuestionTypeModel> questionTypeList =
        dataList.map((data) => QuestionTypeModel.fromJson(data)).toList();
    return questionTypeList;
  }

  Future<List<DifficultyModel>> getQuestionDifficulty() async {
    var request = await dio.get("api/questions/getQuestionDifficulty");
    List<dynamic> dataList = request.data as List;
    List<DifficultyModel> difficultyList =
        dataList.map((data) => DifficultyModel.fromJson(data)).toList();
    return difficultyList;
  }

  Future<QuestionDetailModel> submitQuestion(
      {required String question,
      required String correctAnswer,
      required String selectedQuestionType,
      required List<String> options,
      required String selectedQuestionCategory,
      required String selectedDifficultyId}) async {
    List<Map<String, String>> formattedOption =
        options.map((name) => {"text": name}).toList();

    final userName = await SharedPrefs.getName();
    Map<String, dynamic> queryParameter = {
      "question": question,
      "correctAnswer": correctAnswer,
      "questionType": selectedQuestionType,
      "difficultyId": selectedDifficultyId,
      "categoryId": selectedQuestionCategory,
      "options": formattedOption,
      "createdBy": userName
    };

    var request =
        await dio.post("api/questions/createQuestion", data: queryParameter);

    QuestionDetailModel questionDetailModel =
        QuestionDetailModel.fromJson(request.data);

    return questionDetailModel;
  }

  Future<List<QuizQuestionModel>> getAllQuestions() async {
    var request = await dio.get(
      "api/questions/getAllQuestions",
    );

    List<dynamic> dataList = request.data as List;
    List<QuizQuestionModel> questionList =
        dataList.map((data) => QuizQuestionModel.fromJson(data)).toList();

    return questionList;
  }
}
