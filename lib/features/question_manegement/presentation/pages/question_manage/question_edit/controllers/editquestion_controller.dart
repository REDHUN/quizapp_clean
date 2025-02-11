import 'package:flutter/material.dart';

class EditQuestionController {
  final TextEditingController questionController = TextEditingController();
  String category = 'General Knowledge'; // Default value
  String difficulty = 'Easy'; // Default value
  String questionType = 'Multiple Choice'; // Default value
  List<String> options = List.filled(4, '');
  int? correctAnswerIndex;

  EditQuestionController({String? initialQuestion}) {
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
