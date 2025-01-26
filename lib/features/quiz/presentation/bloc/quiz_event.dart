import 'package:game_app/features/quiz/domain/model/quiz_ans_send_model/quiz_user_ans_model.dart';

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

class GetQuizResultEvent extends QuizEvent {
  int quizId;
  List <UserAnswer> userAnswer;

  GetQuizResultEvent({required this.quizId,required this.userAnswer});

}