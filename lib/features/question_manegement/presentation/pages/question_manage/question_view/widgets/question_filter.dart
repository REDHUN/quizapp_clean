import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';

class QuestionFilter extends StatelessWidget {
  const QuestionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionManageBloc, QuestionManageState>(
      builder: (context, state) {
        final selectedCategory = state.categoryList?.firstWhere(
              (category) => category.id.toString() == state.selectedCategoryId,
          orElse: () => CategoryModel(id: null, name: 'All'),
        );

        final selectedDifficulty = state.questionDifficultyList?.firstWhere(
              (difficulty) => difficulty.id.toString() == state.selectedDifficultyId,
          orElse: () => DifficultyModel(id: null, name: 'All'),
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context: context,
                  label: 'Category: ${selectedCategory?.name ?? 'All'}',
                  icon: Icons.category_outlined,
                  color: AppColors.primary,
                  onTap: () => _showCategoryDialog(context),
                ),
                const SizedBox(width: 12),
                _buildFilterChip(
                  context: context,
                  label: 'Difficulty: ${selectedDifficulty?.name ?? 'All'}',
                  icon: Icons.signal_cellular_alt_rounded,
                  color: _getDifficultyColor(selectedDifficulty?.name ?? 'All'),
                  onTap: () => _showDifficultyDialog(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    final bloc = context.read<QuestionManageBloc>();
    final state = bloc.state;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: state.categoryList
              ?.map((category) => _buildDialogOption(
            context,
            category.name??"",
            state.selectedCategoryId == category.id.toString(),
                () {
              bloc.add(SelectQuestionCategory(categoryId:  category.id.toString()));
              Navigator.pop(context);
            },
          ))
              .toList() ??
              [],
        ),
      ),
    );
  }

  void _showDifficultyDialog(BuildContext context) {
    final bloc = context.read<QuestionManageBloc>();
    final state = bloc.state;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: state.questionDifficultyList
              ?.map((difficulty) => _buildDialogOption(
            context,
            difficulty.name??"",
            state.selectedDifficultyId == difficulty.id.toString(),
                () {
              bloc.add(SelectQuestionDifficulty(difficultyId:  difficulty.id.toString()));
              Navigator.pop(context);
            },
          ))
              .toList() ??
              [],
        ),
      ),
    );
  }

  Widget _buildDialogOption(
      BuildContext context,
      String value,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return ListTile(
      title: Text(value),
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? AppColors.primary : null,
      ),
      onTap: onTap,
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.success;
      case 'medium':
        return AppColors.warning;
      case 'hard':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }
}