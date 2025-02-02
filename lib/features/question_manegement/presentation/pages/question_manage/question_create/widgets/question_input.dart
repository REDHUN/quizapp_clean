
import 'package:flutter/material.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_create/controllers/question_controller.dart';

class QuestionInput extends StatelessWidget {
  final QuestionController controller;
  final String? Function(String?)? validator;

  const QuestionInput({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 3,
      onChanged: (value) => controller.questionText = value,
      validator: validator,
      decoration: InputDecoration(
        hintText: 'Enter your question here',
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
