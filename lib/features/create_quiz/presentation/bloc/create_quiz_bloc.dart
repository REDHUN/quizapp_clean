import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/create_quiz/domain/repository/quiz_create_repository.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_event.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_state.dart';

class CreateQuizBloc extends Bloc<CreateQuiz, CreateQuizState> {
  final CreateQuizRepository createQuizRepository;

  CreateQuizBloc({required this.createQuizRepository})
      : super(CreateQuizState.initial()) {
    on<CreateQuiz>(onCreateQuiz);
  }

  Future onCreateQuiz(CreateQuiz event, Emitter emit) async {
    emit(state.copyWith(status: CreateQuizStatus.loading));
    var data = await createQuizRepository.createQuiz(
        noOfQuestions: event.noOfQuestions,
        quizDescription: event.quizDescription,
        quizName: event.quizTitle);

    if (data.isRight()) {
      emit(state.copyWith(
        status: CreateQuizStatus.success,
      ));
    } else {
      emit(state.copyWith(
          status: CreateQuizStatus.error, errorMessage: data.left.message));
    }
  }
}
