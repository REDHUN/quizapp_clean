import 'package:flutter/material.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/core/theme/app_colors.dart';


class QuestionListItem extends StatelessWidget {
  final String question;
  final String category;
  final String difficulty;
  final String type;
  final List<Option> options;
  final int correctAnswerAnswerId;
  final DateTime lastModified;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.category,
    required this.difficulty,
    required this.type,
    required this.options,
    required this.correctAnswerAnswerId,
    required this.lastModified,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: _getDifficultyColor(difficulty).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getDifficultyColor(difficulty).withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.quiz_outlined,
                  color: _getDifficultyColor(difficulty),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Edit'),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        onTap: onEdit,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.delete, color: AppColors.error),
                        title: Text('Delete',
                            style: TextStyle(color: AppColors.error)),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        onTap: onDelete,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Question Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags Row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag(
                      context,
                      category,
                      Icons.category_outlined,
                      AppColors.primary,
                      isDark,
                    ),
                    _buildTag(
                      context,
                      difficulty,
                      Icons.trending_up,
                      _getDifficultyColor(difficulty),
                      isDark,
                    ),
                    _buildTag(
                      context,
                      type,
                      Icons.quiz_outlined,
                      AppColors.accent,
                      isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Options Preview
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Options:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(
                      options.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              options[index].id==correctAnswerAnswerId
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 16,
                              color:  options[index].id==correctAnswerAnswerId
                                  ? AppColors.success
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                             options[index].text??"",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:  options[index].id==correctAnswerAnswerId
                                      ? AppColors.success
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Last Modified
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Last modified: ${_formatDate(lastModified)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return const Color(0xFF10B981); // Emerald
      case 'medium':
        return const Color(0xFFF59E0B); // Amber
      case 'hard':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF0EA5E9); // Sky Blue
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
