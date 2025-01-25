import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz/domain/model/quiz_question_model/quiz_question_model.dart';



class QuizOptions extends StatelessWidget {
  final List<Option> options;
  final int? selectedIndex;
  final Function(int) onOptionSelected;

  const QuizOptions({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    print("QuizOptions Rebuilt - Selected Index: $selectedIndex"); // Debugging
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final isSelected = selectedIndex == index;
        return InkWell(
          onTap: () => onOptionSelected(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[400]!,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    options[index].text??"",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
