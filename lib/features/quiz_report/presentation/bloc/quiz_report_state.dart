import 'package:equatable/equatable.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_report_model.dart';

enum QuizReportStatus {
  initial,
  quizResultLoading,
  quizResultSuccess,
  quizResultError,
}

class QuizReportState extends Equatable {
  final QuizReportStatus status;
  final String? errorMessage;
  final List<QuizResultReportModel>? quizResultList;

  const QuizReportState._(
      {required this.status, this.errorMessage, this.quizResultList});

  factory QuizReportState.initial() =>
      QuizReportState._(status: QuizReportStatus.initial);

  QuizReportState copyWith({
    QuizReportStatus? status,
    String? errorMessage,
    List<QuizResultReportModel>? quizResultList,
  }) {
    return QuizReportState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        quizResultList: quizResultList ?? this.quizResultList);
  }

  @override

  List<Object?> get props => [status, errorMessage, quizResultList];
}
