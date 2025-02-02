import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

import '../controllers/question_controller.dart';
import 'answer_options_section.dart';
import 'question_details_section.dart';
import 'question_input.dart';
import 'question_type_dropdown.dart';
import 'section_card.dart';

class QuestionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final QuestionController controller;
  final List<QuestionTypeModel> questionTypeList;
  final List<CategoryModel> questionCategoryList;
  final List<DifficultyModel> questionDifficultyList;

  const QuestionForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.questionTypeList,
    required this.questionCategoryList,
    required this.questionDifficultyList
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          SectionCard(
            title: 'Question Type',
            icon: Icons.category_rounded,
            color: AppColors.primary,
            child: QuestionTypeDropdown(
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
          SectionCard(
            title: 'Question Details',
            icon: Icons.quiz_rounded,
            color: AppColors.success,
            child: QuestionDetailsSection(
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
          SectionCard(
            title: 'Question',
            icon: Icons.edit_rounded,
            color: AppColors.warning,
            child: QuestionInput(
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
          AnswerOptionsSection(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an option';
              }
              // Check for duplicate options
              final options =
                  controller.options.where((o) => o.isNotEmpty).toList();
              final uniqueOptions = options.toSet().toList();
              if (options.length != uniqueOptions.length) {
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
