abstract class QuizEvent {}

class GetQuizEvent extends QuizEvent {
  GetQuizEvent();
}
class GetQuizQuestionsEvent extends QuizEvent {
  final String quizId;
  GetQuizQuestionsEvent({required this.quizId});
}
class GetQuizNextQuestionEvent extends QuizEvent{

  GetQuizNextQuestionEvent();
}
class  SelectQuizAnswerEvent extends QuizEvent{
  int selectedIndex;
 int selectedAnswerId;

  SelectQuizAnswerEvent({required this.selectedIndex,required this.selectedAnswerId});
}

class GetQuizPreviousQuestionEvent extends QuizEvent {}