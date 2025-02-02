import 'package:flutter/material.dart';
import 'package:game_app/features/create_quiz/presentation/pages/widgets/create_quiz_custom_text_field.dart';


class QuizTextFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController questionsController;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final bool isWide;

  const QuizTextFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.questionsController,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  }) : isWide = false;

  const QuizTextFields.wide({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.questionsController,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  }) : isWide = true;

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: _buildTitleField(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDescriptionField(),
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildTitleField(),
        const SizedBox(height: 16),
        _buildDescriptionField(),
        const SizedBox(height: 16),
        _buildQuestionsField(),
      ],
    );
  }

  Widget _buildTitleField() {
    return CreateQuizCustomTextField(
      controller: titleController,
      label: 'Quiz Title',
      icon: Icons.title,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter quiz title';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return CreateQuizCustomTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
      controller: descriptionController,
      label: 'Quiz Description',
      icon: Icons.description,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
    );
  }

  Widget _buildQuestionsField() {
    return CreateQuizCustomTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description';
        }
        else if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
      controller: questionsController,
      label: 'Number of Questions',
      icon: Icons.format_list_numbered,
      keyboardType: TextInputType.number,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
    );
  }
}
