class QuestionController {
  String? questionText;
  String category = 'General Knowledge'; // Default value
  String difficulty = 'Easy'; // Default value
  String questionType = 'Multiple Choice'; // Default value
  List<String> options = List.filled(4, '');
  int? correctAnswerIndex;

  QuestionController() {
    // Initialize with default values
    category = 'General Knowledge';
    difficulty = 'Easy';
    questionType = 'Multiple Choice';
  }
}
