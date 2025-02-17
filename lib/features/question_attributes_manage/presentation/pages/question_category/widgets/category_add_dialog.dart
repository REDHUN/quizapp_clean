import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_bloc.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_event.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_state.dart';


class CategoryAddDialog extends StatefulWidget {
  const CategoryAddDialog({super.key});

  @override
  State<CategoryAddDialog> createState() => _CategoryAddDialogState();
}

class _CategoryAddDialogState extends State<CategoryAddDialog> {
  final TextEditingController _categoryController = TextEditingController();
  bool _isActive = false;

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<QuestionAttributeBloc, QuestionAttributeState>(
      listener: (context, state) {
        if (state.status == QuestionAttributeStatus.success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category added successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == QuestionAttributeStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Add Category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _categoryController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.white,
                  hintText: 'Enter category name',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[500],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.category_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildStatusToggle(isDark),
              const SizedBox(height: 24),
              _buildActionButtons(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusToggle(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.toggle_on_outlined,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Active Status',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return BlocBuilder<QuestionAttributeBloc, QuestionAttributeState>(
      buildWhen: (previous, current) =>
      previous.status != current.status, // Only rebuild on status change
      builder: (context, state) {
        final isLoading = state.status == QuestionAttributeStatus.loading;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              // Cancel button should always be enabled
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[300] : Colors.black54,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                if (_categoryController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a category name'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                context.read<QuestionAttributeBloc>().add(
                  AddQuestionCategory(
                    categoryName: _categoryController.text.trim(),
                    categoryId: null,
                    isActive: _isActive,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}