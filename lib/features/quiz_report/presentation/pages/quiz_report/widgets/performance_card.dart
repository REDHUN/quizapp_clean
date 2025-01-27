import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';


class PerformanceCard extends StatelessWidget {
  final String quizName;
  final int correctAnswers;
  final int totalQuestions;

  const PerformanceCard({
    super.key,
    required this.quizName,
    required this.correctAnswers,
    required this.totalQuestions,

  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions) * 100;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkGradient
            : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            quizName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPerformanceItem(
                'Score',
                '${percentage.toInt()}%',
                Icons.stars_rounded,
              ),

              _buildPerformanceItem(
                'Accuracy',
                '${(correctAnswers / totalQuestions * 100).toInt()}%',
                Icons.analytics_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
