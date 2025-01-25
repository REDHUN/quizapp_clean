import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';

enum QuizStatus {
  initial,
  loading,
  success,
  error,
  questionLoading,
  questionLoadSuccess,
  questionLoadError,
  questionCompleted,
  questionSelected,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final String? errorMessage;
  final List<QuizModel>? quizModel;
  final List<QuizQuestionModel>? quizQuestionList;
  final int currentQuestionIndex;
 int ? selectedIndex;
 final List<int> ? selectedAnswerIdList;
  final List<int> ? selectedOptionIndexList;

 QuizState._(
      {required this.status,
      this.errorMessage,
      this.quizModel,
      this.quizQuestionList,
        this.selectedIndex,
        this.selectedAnswerIdList,
        this.selectedOptionIndexList,
      this.currentQuestionIndex = 0});

  factory QuizState.initial() => QuizState._(status: QuizStatus.initial);

  QuizState copyWith({
    QuizStatus? status,
    String? errorMessage,
    List<QuizModel>? quizModel,
    List<QuizQuestionModel>? quizQuestionList,
    int? selectedIndex,
    List<int>? selectedAnswerIdList,
    final List<int> ? selectedOptionIndexList,
    int? currentQuestionIndex,
  }) {
    return QuizState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      quizModel: quizModel ?? this.quizModel,
      quizQuestionList: quizQuestionList ?? this.quizQuestionList,
      selectedIndex: selectedIndex , // Fixed
      selectedAnswerIdList: selectedAnswerIdList ?? this.selectedAnswerIdList, // Fixed
      selectedOptionIndexList: selectedOptionIndexList ?? this.selectedOptionIndexList,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );

  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, errorMessage, quizModel, quizQuestionList,currentQuestionIndex,selectedIndex,selectedOptionIndexList,selectedAnswerIdList];
}
