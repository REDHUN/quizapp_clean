import 'package:flutter/material.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';

class EditQuestionController {
  final TextEditingController questionController = TextEditingController();
  String? category; // Default value
  String? difficulty; // Default value
  String? questionType; // Default value
  List<Option>? options;

  int? correctAnswerIndex;

  EditQuestionController(
      {String? initialQuestion,
      this.correctAnswerIndex,
      this.options,
      this.questionType,
      this.category,
      this.difficulty}) {
    // Initialize the question text if provided
    questionController.text = initialQuestion ?? '';
  }

  // Getter and setter for questionText using controller
  String get questionText => questionController.text;

  set questionText(String value) => questionController.text = value;

  // Dispose method to clean up controllers
  void dispose() {
    questionController.dispose();
  }
}
