import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';


class StartQuizFAB extends StatelessWidget {
  const StartQuizFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const QuizScreen(),
          //   ),
          // );
        },
        label: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Start Quiz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
