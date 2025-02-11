abstract class QuestionManageEvent {}

class GetQuestionCategory extends QuestionManageEvent {
  GetQuestionCategory();
}

class GetQuestionDifficulty extends QuestionManageEvent {
  GetQuestionDifficulty();
}

class GetQuestionType extends QuestionManageEvent {
  GetQuestionType();
}
class SelectQuestionCategory extends QuestionManageEvent {
  final String categoryId;

  SelectQuestionCategory({required this.categoryId});
}

class SelectQuestionDifficulty extends QuestionManageEvent {
  final String difficultyId;

  SelectQuestionDifficulty({required this.difficultyId});
}
class SelectQuestionTypeId extends QuestionManageEvent {
  final String questiontypeId;

  SelectQuestionTypeId({required this.questiontypeId});
}

class SubmitQuestion extends QuestionManageEvent {
  final String  question;
  final String correctAnswer;
  final List<String>options;

  SubmitQuestion({required this.question,required this.correctAnswer,required this.options});
}
class ResetQuestionManageState extends QuestionManageEvent {}
class GetAllQuestions extends QuestionManageEvent {}