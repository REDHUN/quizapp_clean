import 'package:flutter/material.dart';

import 'quiz_dropdowns.dart';
import 'quiz_submit_button.dart';
import 'quiz_text_fields.dart';

class QuizForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isWideScreen;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController questionsController;
  final String? selectedCategory;
  final String? selectedGroup;
  final List<String> categories;
  final List<String> groups;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color buttonColor;
  final Function(String?) onCategoryChanged;
  final Function(String?) onGroupChanged;
  final VoidCallback onSubmit;

  const QuizForm({
    super.key,
    required this.formKey,
    required this.isWideScreen,
    required this.titleController,
    required this.descriptionController,
    required this.questionsController,
    required this.selectedCategory,
    required this.selectedGroup,
    required this.categories,
    required this.groups,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.buttonColor,
    required this.onCategoryChanged,
    required this.onGroupChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWideScreen)
            Column(
              children: [
                QuizTextFields.wide(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  questionsController: questionsController,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                const SizedBox(height: 16),
                QuizDropdowns.wide(
                  selectedCategory: selectedCategory,
                  selectedGroup: selectedGroup,
                  categories: categories,
                  groups: groups,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  iconColor: iconColor,
                  onCategoryChanged: onCategoryChanged,
                  onGroupChanged: onGroupChanged,
                ),
              ],
            )
          else
            Column(
              children: [
                QuizTextFields(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  questionsController: questionsController,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                const SizedBox(height: 16),
                QuizDropdowns(
                  selectedCategory: selectedCategory,
                  selectedGroup: selectedGroup,
                  categories: categories,
                  groups: groups,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  iconColor: iconColor,
                  onCategoryChanged: onCategoryChanged,
                  onGroupChanged: onGroupChanged,
                ),
              ],
            ),
          const SizedBox(height: 32),
          QuizSubmitButton(
            onPressed: onSubmit,
            buttonColor: buttonColor,
          ),
        ],
      ),
    );
  }
}
