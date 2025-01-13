import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;

  QuizBloc({required this.quizRepository}) : super(QuizState.initial()) {
    on<GetQuizEvent>(onGetQuizEvent);
  }

  Future onGetQuizEvent(QuizEvent event, Emitter emit) async {
    emit(state.copyWith(status: QuizStatus.loading));
    var data = await quizRepository.getQuizList();

    if (data.isRight()) {
      // Emit success state with user token

      emit(state.copyWith(status: QuizStatus.success, quizModel: data.right));
    } else {
      emit(state.copyWith(
          status: QuizStatus.error, errorMessage: data.left.message));
    }
  }
}
