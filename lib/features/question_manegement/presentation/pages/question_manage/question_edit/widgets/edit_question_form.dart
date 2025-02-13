import 'package:flutter/material.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

import '../controllers/editquestion_controller.dart';
import 'edit_answer_options_section.dart';
import 'edit_question_details_section.dart';
import 'edit_question_input.dart';
import 'edit_question_type_dropdown.dart';
import 'edit_section_card.dart';

class EditQuestionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final EditQuestionController controller;
  final List<QuestionTypeModel> questionTypeList;
  final List<CategoryModel> questionCategoryList;
  final List<DifficultyModel> questionDifficultyList;
  final List<Option>? options;
final int ? correctAnswerId;

  const EditQuestionForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.questionTypeList,
    required this.questionCategoryList,
    required this.questionDifficultyList,
this.options,
this.correctAnswerId
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          EditQuestionSectionCard(
            title: 'Question Type',
            icon: Icons.category_rounded,
            color: AppColors.primary,
            child: EditQuestionTypeDropdown(
              questionTypeList: questionTypeList,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a question type';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
         EditQuestionSectionCard(
            title: 'Question Details',
            icon: Icons.quiz_rounded,
            color: AppColors.success,
            child: EditQuestionDetailsSection(
              questionDifficultyList: questionDifficultyList??[],
              questionCategoryLit: questionCategoryList,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          EditQuestionSectionCard(
            title: 'Question',
            icon: Icons.edit_rounded,
            color: AppColors.warning,
            child: EditQuestionInput(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a question';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          EditAnswerOptionsSection(
            options: options,
            correctAnswerId: correctAnswerId,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an option';
              }
              // Check for duplicate options
              final options =
                  controller.options?.where((o) => o.text?.isNotEmpty??false).toList();
              final uniqueOptions = options?.toSet().toList();
              if (options?.length != uniqueOptions?.length) {
                return 'Options must be unique';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
