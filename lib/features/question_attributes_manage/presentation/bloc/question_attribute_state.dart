import 'package:equatable/equatable.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/core/model/question_type_model/question_type_model.dart';

enum QuestionAttributeStatus {
  initial,
  loading,
  success,
  error,
  categoryAdding

}

class QuestionAttributeState extends Equatable {
  final QuestionAttributeStatus status;
  final String? errorMessage;
  final List<CategoryModel>? categoryList;
  final List<DifficultyModel>? questionDifficultyList;
  final List<QuestionTypeModel>? questionTypeList;
  final bool ? isCategoryUsed;


  const QuestionAttributeState._({
    required this.status,
    this.errorMessage,
    this.categoryList,
    this.questionTypeList,
    this.questionDifficultyList,
    this.isCategoryUsed
  });

  factory QuestionAttributeState.initial() => const QuestionAttributeState._(
    status: QuestionAttributeStatus.initial,
  );

  QuestionAttributeState copyWith({
    QuestionAttributeStatus? status,
    String? errorMessage,
    List<CategoryModel>? categoryList,
    List<DifficultyModel>? questionDifficultyList,
    List<QuestionTypeModel>? questionTypeList,
 bool ? isCategoryUsed,
  }) {
    return QuestionAttributeState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryList: categoryList ?? this.categoryList,
      questionDifficultyList:
      questionDifficultyList ?? this.questionDifficultyList,
      questionTypeList: questionTypeList ?? this.questionTypeList,
      isCategoryUsed: isCategoryUsed??this.isCategoryUsed
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    categoryList,
    questionDifficultyList,
    questionTypeList,
    isCategoryUsed
  ];
}
