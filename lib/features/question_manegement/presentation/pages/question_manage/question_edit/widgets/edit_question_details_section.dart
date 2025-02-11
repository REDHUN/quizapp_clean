import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/controllers/editquestion_controller.dart';

class EditQuestionDetailsSection extends StatelessWidget {
  final  EditQuestionController controller;
  final String? Function(String?)? validator;
  final List<CategoryModel> questionCategoryLit;
  final List<DifficultyModel> questionDifficultyList;

  const EditQuestionDetailsSection({
    super.key,
    required this.controller,
    this.validator,
    required this.questionDifficultyList,
    required this.questionCategoryLit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<QuestionManageBloc, QuestionManageState, String?>(
          selector: (state) => state.selectedCategoryId?.toString(),
          builder: (context, selectedCategoryId) {
            return DropdownButtonFormField<String>(
              value: selectedCategoryId,
              onChanged: (value) {
                if (value != null) {
                  context.read<QuestionManageBloc>().add(SelectQuestionCategory(categoryId: value));
                }
              },
              validator: validator,
              items: questionCategoryLit
                  .map((category) => DropdownMenuItem(
                value: category.id.toString(),
                child: Text(category.name ?? ""),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        BlocSelector<QuestionManageBloc, QuestionManageState, String?>(
          selector: (state) => state.selectedDifficultyId?.toString(),
          builder: (context, selectedDifficultyId) {
            return DropdownButtonFormField<String>(
              validator: validator,
              value: selectedDifficultyId,
              onChanged: (value) {
                if (value != null) {
                  context.read<QuestionManageBloc>().add(SelectQuestionDifficulty(difficultyId: value));
                }
              },
              items: questionDifficultyList
                  .map((difficulty) => DropdownMenuItem(
                value: difficulty.id.toString(),
                child: Text(difficulty.name ?? ""),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Difficulty',
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}