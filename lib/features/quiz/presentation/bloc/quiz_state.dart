import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model.dart';

enum QuizStatus {
  initial,
  loading,
  success,
  error,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final String? errorMessage;
  final List<QuizModel>? quizModel;

  const QuizState._({required this.status, this.errorMessage, this.quizModel});

  factory QuizState.initial() => QuizState._(status: QuizStatus.initial);

  QuizState copyWith(
      {QuizStatus? status, String? errorMessage, List<QuizModel>? quizModel}) {
    return QuizState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        quizModel: quizModel ?? this.quizModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessage, quizModel];
}
