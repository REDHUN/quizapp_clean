import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/question_manegement/domain/repository/question_manage_repository.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';

class QuestionManageBloc
    extends Bloc<QuestionManageEvent, QuestionManageState> {
  final QuestionManageRepository questionManageRepository;

  QuestionManageBloc({required this.questionManageRepository})
      : super(QuestionManageState.initial()) {
    on<GetQuestionCategory>(onGetQuestionCategory);
    on<GetQuestionDifficulty>(onGetQuestionDifficulty);
    on<GetQuestionType>(onGetQuestionType);
    on<SelectQuestionCategory>(onSelectQuestionCategory);
    on<SelectQuestionDifficulty>(onSelectQuestionDifficulty);
    on<SelectQuestionTypeId>(onSelectQuestionTypeId);
    on<SubmitQuestion>(onSubmitQuestion);
  }

  Future onGetQuestionCategory(GetQuestionCategory event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.getQuestionCategory();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionManageStatus.success, categoryList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  Future onGetQuestionDifficulty(
      GetQuestionDifficulty event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.getQuestionDifficulty();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionManageStatus.success,
          questionDifficultyList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  Future onGetQuestionType(GetQuestionType event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.getQuestionType();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionManageStatus.success, questionTypeList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  void onSelectQuestionCategory(
      SelectQuestionCategory event, Emitter<QuestionManageState> emit) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void onSelectQuestionDifficulty(
      SelectQuestionDifficulty event, Emitter<QuestionManageState> emit) {
    emit(state.copyWith(selectedDifficultyId: event.difficultyId));
  }

  void onSelectQuestionTypeId(
      SelectQuestionTypeId event, Emitter<QuestionManageState> emit) {
    emit(state.copyWith(selectedQuestionTypeId: event.questiontypeId));
  }

  Future onSubmitQuestion(SubmitQuestion event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.submitQuestion(
        question: event.question,
        correctAnswer: event.correctAnswer,
        selectedQuestionType: state.selectedQuestionTypeId ?? "",
        options: event.options,
        selectedQuestionCategory: state.selectedCategoryId ?? "",
        selectedDifficultyId: state.selectedDifficultyId ?? "");

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.questionSubmitSuccess));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.questionSubmitError, errorMessage: data.left.message));
    }
  }
}
