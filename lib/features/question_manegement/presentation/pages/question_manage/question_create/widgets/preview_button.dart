import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';

import '../controllers/question_controller.dart';
import '../preview/question_preview_dialog.dart';

class PreviewButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final QuestionController controller;

  const PreviewButton({
    super.key,
    required this.formKey,
    required this.controller,
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
                } else if (controller.options
                        .where((o) => o.isNotEmpty)
                        .length <
                    2) {
                  _showValidationError(
                    context,
                    'Please add at least two options',
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => QuestionPreviewDialog(
                      question: controller.questionText,
                      category: controller.category,
                      difficulty: controller.difficulty,
                      questionType: controller.questionType,
                      options: controller.options,
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
