import 'package:dio/dio.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/core/model/question_type_model/question_type_model.dart';

class QuestionAttributeDatasource{

  final Dio dio;

  QuestionAttributeDatasource({required this.dio});

  Future<List<CategoryModel>> getQuestionCategory() async {
    var request = await dio.get("api/questions/getQuestionCategory");
    List<dynamic> dataList = request.data as List;
    List<CategoryModel> categoryList =
    dataList.map((data) => CategoryModel.fromJson(data)).toList();
    return categoryList;
  }
  Future<CategoryModel> addQuestionCategory({required String  categoryName, int ? categoryId,required bool isActive}) async {
    Map<String,dynamic>queryParameter={
      "category": categoryName,
      "categoryId" : categoryId,
      "isActive" : isActive?"Y":"N"
    };
    var request = await dio.post("/api/admin/questions/saveCategory",data: queryParameter);

    CategoryModel category =
     CategoryModel.fromJson(request.data);
    return category;
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
}