import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/question_manegement/domain/repository/question_manage_repository.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';

class QuestionManageBloc
    extends Bloc<QuestionManageEvent, QuestionManageState> {
  final QuestionManageRepository questionManageRepository;

  QuestionManageBloc({required this.questionManageRepository})
      : super(QuestionManageState.initial()) {
    on<FetchQuestionData>(_onFetchQuestionData);
    on<GetAllQuestions>(_onGetAllQuestions);
    on<GetFilteredQuestions>(_onGetFilteredQuestions);
    on<SelectQuestionCategory>((event, emit) =>
        emit(state.copyWith(selectedCategoryId: event.categoryId)));
    on<SelectQuestionDifficulty>((event, emit) =>
        emit(state.copyWith(selectedDifficultyId: event.difficultyId)));
    on<SelectQuestionTypeId>((event, emit) =>
        emit(state.copyWith(selectedQuestionTypeId: event.questiontypeId)));
    on<SubmitQuestion>(_onSubmitQuestion);
    on<EditQuestion>(_onEditQuestion);
    on<DeleteQuestion>(_onDeleteQuestion);
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
    print("ssssss");
  }

  void onSelectQuestionDifficulty(
      SelectQuestionDifficulty event, Emitter<QuestionManageState> emit) {
    emit(state.copyWith(selectedDifficultyId: event.difficultyId));
  }

  void _onFetchQuestionData(
      FetchQuestionData event, Emitter<QuestionManageState> emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));

    var categoryData = await questionManageRepository.getQuestionCategory();
    var difficultyData = await questionManageRepository.getQuestionDifficulty();
    var typeData = await questionManageRepository.getQuestionType();

    if (categoryData.isRight() &&
        difficultyData.isRight() &&
        typeData.isRight()) {
      emit(state.copyWith(
        status: QuestionManageStatus.success,
        categoryList: categoryData.right,
        questionDifficultyList: difficultyData.right,
        questionTypeList: typeData.right,
      ));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error,
          errorMessage: "Failed to fetch data. Please try again."));
    }
  }

  void onSelectQuestionTypeId(
      SelectQuestionTypeId event, Emitter<QuestionManageState> emit) {
    emit(state.copyWith(selectedQuestionTypeId: event.questiontypeId));
  }

  Future _onSubmitQuestion(SubmitQuestion event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.submitQuestion(
        question: event.question,
        correctAnswer: event.correctAnswer,
        selectedQuestionType: event.questionTypeId ?? "",
        options: event.options,
        selectedQuestionCategory: event.questionCategoryId ?? "",
        selectedDifficultyId: event.questionDifficultyId ?? "");

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.questionSubmitSuccess));

      emit(state.copyWith(status: QuestionManageStatus.questionSubmitSuccess));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.questionSubmitError,
          errorMessage: data.left.message));
    }
  }

  Future _onEditQuestion(EditQuestion event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.editQuestion(
        question: event.question,
        correctAnswer: event.correctAnswer,
        selectedQuestionType: event.questionTypeId ?? "",
        options: event.options,
        selectedQuestionCategory: event.questionDifficultyId ?? "",
        selectedDifficultyId: event.questionDifficultyId ?? "",
        questionId: event.questionId);

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.questionSubmitSuccess));

      emit(state.copyWith(status: QuestionManageStatus.questionSubmitSuccess));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.questionSubmitError,
          errorMessage: data.left.message));
    }
  }

  Future _onGetAllQuestions(GetAllQuestions event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.getAllQuestions();

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.success));

      emit(state.copyWith(questionList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  Future _onGetFilteredQuestions(
      GetFilteredQuestions event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    print("Question Difficulty id in event${event.questionDifficultyId}");
    var data = await questionManageRepository.getFilteredQuestions(
        questionCategoryId: event.questionCategoryId,
        questionDifficultyId: event.questionDifficultyId,
        questionTypeId: event.questionTypeId);

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.success));

      emit(state.copyWith(questionList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  Future _onDeleteQuestion(DeleteQuestion event, Emitter emit) async {
    emit(state.copyWith(status: QuestionManageStatus.loading));
    var data = await questionManageRepository.deleteQuestion(
        questionId: event.questionId);

    if (data.isRight()) {
      emit(state.copyWith(status: QuestionManageStatus.questionDeleteSuccess));
    } else {
      emit(state.copyWith(
          status: QuestionManageStatus.error, errorMessage: data.left.message));
    }
  }

  void onResetQuestionManageState(
      ResetQuestionManageState event, Emitter<QuestionManageState> emit) {
    emit(QuestionManageState.initial());
  }
}
