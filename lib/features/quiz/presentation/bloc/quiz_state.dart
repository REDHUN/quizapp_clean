import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_ans_send_model/quiz_user_ans_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_result_model/quiz_result_model.dart';

enum QuizStatus {
  initial,
  loading,
  success,
  error,
  questionLoading,
  questionLoadSuccess,
  questionLoadError,
  questionCompleted,
  quizResultLoading,
  quizResultSuccess,
  quizResultError,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final String? errorMessage;
  final List<QuizModel>? quizModel;
  final List<QuizQuestionModel>? quizQuestionList;
  final int currentQuestionIndex;
 int ? selectedIndex;
 final List<UserAnswer> ? selectedAnswerIdList;
  final List<int> ? selectedOptionIndexList;
  final QuizResultModel  ? quizResultModel;

 QuizState._(
      {required this.status,
      this.errorMessage,
      this.quizModel,
      this.quizQuestionList,
        this.selectedIndex,
        this.selectedAnswerIdList,
        this.selectedOptionIndexList,
        this.quizResultModel,
      this.currentQuestionIndex = 0});

  factory QuizState.initial() => QuizState._(status: QuizStatus.initial);

  QuizState copyWith({
    QuizStatus? status,
    String? errorMessage,
    List<QuizModel>? quizModel,
   QuizResultModel  ? quizResultModel,
    List<QuizQuestionModel>? quizQuestionList,
    int? selectedIndex,
    List<UserAnswer>? selectedAnswerIdList,
    final List<int> ? selectedOptionIndexList,
    int? currentQuestionIndex,
  }) {
    return QuizState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      quizResultModel: quizResultModel?? this.quizResultModel,
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
