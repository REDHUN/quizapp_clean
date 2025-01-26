import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/quiz_report/domain/repository/quiz_report_repository.dart';
import 'package:game_app/features/quiz_report/presentation/bloc/quiz_report_event.dart';
import 'package:game_app/features/quiz_report/presentation/bloc/quiz_report_state.dart';

class QuizReportBloc extends Bloc<QuizReportEvent, QuizReportState> {
  final QuizReportRepository quizReportRepository;

  QuizReportBloc({required this.quizReportRepository})
      : super(QuizReportState.initial()) {
    on<GetQuizResultEvent>(onGetQuizReportEvent);
  }

  Future onGetQuizReportEvent(GetQuizResultEvent event, Emitter emit) async {
    emit(state.copyWith(status: QuizReportStatus.quizResultLoading));
    var data = await quizReportRepository.getQuizResultList();

    if (data.isRight()) {
      // Emit success state with user token

      emit(state.copyWith(
          status: QuizReportStatus.quizResultSuccess,
          quizResultList: data.right));
    } else {
      emit(state.copyWith(
          status: QuizReportStatus.quizResultError,
          errorMessage: data.left.message));
    }
  }
}
