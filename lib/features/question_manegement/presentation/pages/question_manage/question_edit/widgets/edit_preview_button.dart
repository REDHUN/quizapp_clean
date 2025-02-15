import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

import '../controllers/editquestion_controller.dart';
import '../preview/question_preview_dialog.dart';

class EditPreviewButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final EditQuestionController controller;
  final List<QuestionTypeModel> questionTypeList;
  final List<CategoryModel> questionCategoryList;
  final List<DifficultyModel> questionDifficultyList;
  final int questionId;
  const EditPreviewButton({
    super.key,
    required this.formKey,
    required this.controller,
    required this.questionTypeList,
    required this.questionCategoryList,
    required this.questionDifficultyList,

   required this.questionId
  });

  void _showValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 80, // Adjusted margin to prevent overlap with bottom buttons
            right: 20,
            left: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.2)),
              ),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  _showValidationError(
                    context,
                    'Please fill in all required fields',
                  );
                } else if (controller.correctAnswerIndex == null) {
                  _showValidationError(
                    context,
                    'Please select a correct answer',
                  );
                } else if ((controller.options??[])
                        .where((o) => o.text?.isNotEmpty??false)
                        .length <
                    2) {
                  _showValidationError(
                    context,
                    'Please add at least two options',
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => EditQuestionPreviewDialog(
                      questionId: questionId,
                      difficultyName: questionDifficultyList
                          .firstWhere(
                            (difficulty) =>
                        difficulty.id.toString() == controller.difficulty,
                        orElse: () => DifficultyModel(),
                      )
                          .name,
                      categoryName: questionCategoryList
                          .firstWhere(
                            (category) => category.id.toString() == controller.category,
                        orElse: () => CategoryModel(),
                      )
                          .name,
                      questionTypeName: questionTypeList
                          .firstWhere(
                            (questionType) =>
                        questionType.id.toString() == controller.questionType,
                        orElse: () => QuestionTypeModel(),
                      )
                          .name,
                      question: controller.questionText,
                      category: controller.category,
                      difficulty: controller.difficulty,
                      questionType: controller.questionType,
                      options: controller.options??[],
                      correctAnswerIndex: controller.correctAnswerIndex,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.preview_rounded),
              label: const Text(
                'Preview Question',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
