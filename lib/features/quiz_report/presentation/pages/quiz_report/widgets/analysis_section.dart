import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';



class AnalysisSection extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const AnalysisSection({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      // padding: const EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(24),
      //   border: Border.all(color: Colors.grey[200]!),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey[200]!,
      //       blurRadius: 10,
      //       offset: const Offset(0, 5),
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
           child: Text(
              'Performance Analysis',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
         ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildAnalysisItem(
              'Correct Answers',
              correctAnswers,
              totalQuestions,
              AppColors.success,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: _buildAnalysisItem(
              'Wrong Answers',
              totalQuestions - correctAnswers,
              totalQuestions,
              AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(
    String label,
    int value,
    int total,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$value/$total',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / total,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
