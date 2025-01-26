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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(
          options.length,
              (index) {
            final isSelected = selectedIndex == index;
            final option = options[index];
            final letter = String.fromCharCode(65 + index); // A, B, C, D...

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 200 + (index * 100)),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onOptionSelected(index),
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey[200]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.05)
                                  : Colors.white,
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                else
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.grey[100],
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey[300]!,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: AppColors.primary
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                    ],
                                  ),
                                  child: Center(
                                    child: isSelected
                                        ? const Icon(
                                      Icons.check_rounded,
                                      size: 24,
                                      color: Colors.white,
                                    )
                                        : Text(
                                      letter,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    option.text??"",
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1.2,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey[800],
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
