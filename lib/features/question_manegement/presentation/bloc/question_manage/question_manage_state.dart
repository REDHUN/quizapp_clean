import 'package:equatable/equatable.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

enum QuestionManageStatus {
  initial,
  loading,
  success,
  error,
  questionSubmitSuccess,
  questionSubmitError,
  questionDeleteSuccess,
}

class QuestionManageState extends Equatable {
  final QuestionManageStatus status;
  final String? errorMessage;
  final List<CategoryModel>? categoryList;
  final List<DifficultyModel>? questionDifficultyList;
  final List<QuestionTypeModel>? questionTypeList;
  final String? selectedCategoryId;
  final String? selectedDifficultyId;
  final String? selectedQuestionTypeId;
  final List<String>? options;
  final String? question;
  final String? correctAnswer;
  final List<QuizQuestionModel>? questionList;

  const QuestionManageState._(
      {required this.status,
      this.errorMessage,
      this.categoryList,
      this.questionTypeList,
      this.questionDifficultyList,
      this.selectedCategoryId,
      this.selectedDifficultyId,
      this.selectedQuestionTypeId,
      this.correctAnswer,
      this.question,
      this.options,
      this.questionList});

  factory QuestionManageState.initial() => const QuestionManageState._(
        status: QuestionManageStatus.initial,
      );

  QuestionManageState copyWith({
    QuestionManageStatus? status,
    String? errorMessage,
    List<CategoryModel>? categoryList,
    List<DifficultyModel>? questionDifficultyList,
    List<QuestionTypeModel>? questionTypeList,
    String? selectedCategoryId,
    String? selectedDifficultyId,
    String? selectedQuestionTypeId,
    String? correctAnswer,
    String? question,
    List<String>? options,
    List<QuizQuestionModel>? questionList,
  }) {
    return QuestionManageState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        categoryList: categoryList ?? this.categoryList,
        questionDifficultyList:
            questionDifficultyList ?? this.questionDifficultyList,
        questionTypeList: questionTypeList ?? this.questionTypeList,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        selectedDifficultyId: selectedDifficultyId ?? this.selectedDifficultyId,
        selectedQuestionTypeId:
            selectedQuestionTypeId ?? this.selectedQuestionTypeId,
        options: options ?? this.options,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        question: question ?? this.question,
        questionList: questionList ?? this.questionList);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        categoryList,
        questionDifficultyList,
        selectedCategoryId,
        selectedDifficultyId,
        questionTypeList,
        selectedQuestionTypeId,
        question,
        options,
        correctAnswer,
        questionList
      ];
}
