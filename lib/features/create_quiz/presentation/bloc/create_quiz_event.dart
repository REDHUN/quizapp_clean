abstract class CreateQuizEvent {}

class CreateQuiz extends CreateQuizEvent {
  final String quizTitle;
  final String quizDescription;
  final int noOfQuestions;

  CreateQuiz({required this.quizTitle, required this.quizDescription,required this.noOfQuestions});
}

