import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;

  QuizBloc({required this.quizRepository}) : super(QuizState.initial()) {
    on<GetQuizEvent>(onGetQuizEvent);
    on<GetQuizQuestionsEvent>(onGetQuizQuestionsEvent);
    on<GetQuizNextQuestionEvent>(onGetQuizNextQuestionEvent);
    on<SelectQuizAnswerEvent>(onSelectQuizAnswerEvent);
    on<GetQuizPreviousQuestionEvent>(onGetQuizPreviousQuestionEvent);
  }

  Future onGetQuizEvent(GetQuizEvent event, Emitter emit) async {
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

  Future onGetQuizQuestionsEvent(
      GetQuizQuestionsEvent event, Emitter emit) async {
    emit(state.copyWith(status: QuizStatus.questionLoading));
    var data = await quizRepository.getQuizQuestions(quizId: event.quizId);

    if (data.isRight()) {
      // Emit success state with user token

      emit(state.copyWith(
          status: QuizStatus.questionLoadSuccess,
          quizQuestionList: data.right));
    } else {
      emit(state.copyWith(
          status: QuizStatus.questionLoadError,
          errorMessage: data.left.message));
    }
  }

  Future onGetQuizNextQuestionEvent(
      GetQuizNextQuestionEvent event, Emitter emit) async {
    if (state.quizQuestionList != null &&
        state.currentQuestionIndex < state.quizQuestionList!.length - 1) {
      // Get the selected answer for the next question (if any)
      int? selectedIndexForNextQuestion =
          state.selectedOptionIndexList != null &&
                  state.selectedOptionIndexList!.length >
                      state.currentQuestionIndex + 1
              ? state.selectedOptionIndexList![state.currentQuestionIndex + 1]
              : null;

      emit(state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedIndex: selectedIndexForNextQuestion,
        // Restore selectedIndex from selectedAnswerList
        status: QuizStatus.questionLoadSuccess,
      ));
    } else {
      emit(state.copyWith(
        status: QuizStatus.questionCompleted,
      ));
    }
  }

  Future onSelectQuizAnswerEvent(
      SelectQuizAnswerEvent event, Emitter emit) async {
    // Update the selectedAnswerList
    List<int> updatedSelectedOptionIndexList =
        List.from(state.selectedOptionIndexList ?? []);
    List<int> updatedSelectedAnswerIdList =
        List.from(state.selectedAnswerIdList ?? []);
    if (state.currentQuestionIndex < updatedSelectedOptionIndexList.length) {
      updatedSelectedAnswerIdList[state.currentQuestionIndex] =
          event.selectedAnswerId;
      updatedSelectedOptionIndexList[state.currentQuestionIndex] =
          event.selectedIndex;
    } else {
      updatedSelectedOptionIndexList.add(event.selectedIndex);
      updatedSelectedAnswerIdList.add(event.selectedAnswerId);
    }

    emit(state.copyWith(
      selectedAnswerIdList: updatedSelectedAnswerIdList,
      selectedIndex: event.selectedIndex,
      selectedOptionIndexList: updatedSelectedOptionIndexList,
      status: QuizStatus.questionLoadSuccess,
    ));
  }

  Future onGetQuizPreviousQuestionEvent(
      GetQuizPreviousQuestionEvent event, Emitter emit) async {
    if (state.quizQuestionList != null && state.currentQuestionIndex > 0) {
      // Get the previously selected answer (if any)
      int? previouslySelectedIndex = state.selectedOptionIndexList != null &&
              state.selectedOptionIndexList!.length >
                  state.currentQuestionIndex - 1
          ? state.selectedOptionIndexList![state.currentQuestionIndex - 1]
          : null;

      emit(state.copyWith(
        selectedAnswerIdList: state.selectedAnswerIdList,
        currentQuestionIndex: state.currentQuestionIndex - 1,
        selectedIndex: previouslySelectedIndex,
        // Set to previously selected answer
        status: QuizStatus.questionLoadSuccess,
      ));
    }
  }
}
