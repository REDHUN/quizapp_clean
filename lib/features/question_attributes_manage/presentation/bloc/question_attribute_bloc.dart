import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/question_attributes_manage/domain/repository/question_attribute_repository.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_event.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_state.dart';

class QuestionAttributeBloc
    extends Bloc<QuestionAttributeEvent, QuestionAttributeState> {
  final QuestionAttributeRepository questionAttributeRepository;

  QuestionAttributeBloc({required this.questionAttributeRepository})
      : super(QuestionAttributeState.initial()) {
    on<GetQuestionType>(onGetQuestionType);
    on<GetQuestionDifficulty>(onGetQuestionDifficulty);
    on<GetQuestionCategory>(onGetQuestionCategory);
    on<AddQuestionCategory>(onAddQuestionCategory);
  }

  Future onGetQuestionCategory(GetQuestionCategory event, Emitter emit) async {
    emit(state.copyWith(status: QuestionAttributeStatus.loading));
    var data = await questionAttributeRepository.getQuestionCategory();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionAttributeStatus.success, categoryList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionAttributeStatus.error,
          errorMessage: data.left.message));
    }
  }
  Future onAddQuestionCategory(AddQuestionCategory event, Emitter emit) async {
    emit(state.copyWith(status: QuestionAttributeStatus.loading));
    var data = await questionAttributeRepository.addQuestionCategory(categoryName: event.categoryName, categoryId: event.categoryId);

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionAttributeStatus.success,));
    } else {
      emit(state.copyWith(
          status: QuestionAttributeStatus.error,
          errorMessage: data.left.message));
    }
  }

  Future onGetQuestionDifficulty(
      GetQuestionDifficulty event, Emitter emit) async {
    emit(state.copyWith(status: QuestionAttributeStatus.loading));
    var data = await questionAttributeRepository.getQuestionDifficulty();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionAttributeStatus.success,
          questionDifficultyList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionAttributeStatus.error,
          errorMessage: data.left.message));
    }
  }

  Future onGetQuestionType(GetQuestionType event, Emitter emit) async {
    emit(state.copyWith(status: QuestionAttributeStatus.loading));
    var data = await questionAttributeRepository.getQuestionType();

    if (data.isRight()) {
      emit(state.copyWith(
          status: QuestionAttributeStatus.success,
          questionTypeList: data.right));
    } else {
      emit(state.copyWith(
          status: QuestionAttributeStatus.error,
          errorMessage: data.left.message));
    }
  }
}
