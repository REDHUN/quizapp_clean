
abstract class QuestionAttributeEvent {}

class GetQuestionCategory extends QuestionAttributeEvent {
  GetQuestionCategory();
}
class AddQuestionCategory extends QuestionAttributeEvent {
  final String categoryName;
  final int ? categoryId;
  final bool isActive;

  AddQuestionCategory({required this.categoryName,  this.categoryId,required this.isActive});

}
class GetQuestionDifficulty extends QuestionAttributeEvent {
  GetQuestionDifficulty();
}

class GetQuestionType extends QuestionAttributeEvent {
  GetQuestionType();
}