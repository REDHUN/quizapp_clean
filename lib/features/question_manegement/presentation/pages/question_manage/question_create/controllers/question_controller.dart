class QuestionController {
  String? questionText;
  String ?category ;// Default value
  String ? difficulty ;
  String ?questionType;
  String? categoryId;
  String? difficultyId;
  String? questionTypeId;

  List<String> options = List.filled(4, '');
  int? correctAnswerIndex;

  QuestionController() {
    // Initialize with default values
    category;
    difficulty;
    questionType;
    questionTypeId;
    categoryId;
    difficultyId;
  }
}
