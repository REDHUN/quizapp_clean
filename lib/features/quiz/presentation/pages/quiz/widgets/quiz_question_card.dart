import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/core/theme/grediant.dart';


class QuizQuestionCard extends StatelessWidget {
  final int questionNumber;
  final String question;
  final String? imageUrl;

  const QuizQuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = GradientColors.getGradientByIndex(questionNumber - 1);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: isDark
            ? Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        )
            : null,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.1),
                      BlendMode.darken,
                    ),
                    child: Image.network(
                      imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          gradient[0].withOpacity(isDark ? 0.3 : 0.2),
                          gradient[1].withOpacity(isDark ? 0.2 : 0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradient[0].withOpacity(isDark ? 0.3 : 0.1),
                        gradient[1].withOpacity(isDark ? 0.2 : 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: gradient[0].withOpacity(isDark ? 0.3 : 0.2),
                    ),
                    boxShadow: isDark
                        ? [
                      BoxShadow(
                        color: gradient[0].withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Text(
                    'Question $questionNumber',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
