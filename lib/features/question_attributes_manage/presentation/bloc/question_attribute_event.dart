
abstract class QuestionAttributeEvent {}

class GetQuestionCategory extends QuestionAttributeEvent {
  GetQuestionCategory();
}
class AddQuestionCategory extends QuestionAttributeEvent {
  final String categoryName;
  final int ? categoryId;

  AddQuestionCategory({required this.categoryName,  this.categoryId});

}
class GetQuestionDifficulty extends QuestionAttributeEvent {
  GetQuestionDifficulty();
}

class GetQuestionType extends QuestionAttributeEvent {
  GetQuestionType();
}