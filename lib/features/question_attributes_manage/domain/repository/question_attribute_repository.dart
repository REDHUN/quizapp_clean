import 'package:game_app/core/failure/failute.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/core/model/either.dart';
import 'package:game_app/core/model/question_type_model/question_type_model.dart';

abstract class QuestionAttributeRepository {
  Future<Either<Failure, List<CategoryModel>>> getQuestionCategory();
  Future<Either<Failure, CategoryModel>> addQuestionCategory({required String categoryName,int ? categoryId,required bool isActive});

  Future<Either<Failure, List<QuestionTypeModel>>> getQuestionType();

  Future<Either<Failure, List<DifficultyModel>>> getQuestionDifficulty();
}
