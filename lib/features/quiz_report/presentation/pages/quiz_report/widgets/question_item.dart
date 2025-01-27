import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_model.dart';


class QuestionItem extends StatelessWidget {
  final QuestionResult ?  question;
  final int index;

  const QuestionItem({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = question?.userAnswer==question?.correctAnswer;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: isCorrect
      //         ? AppColors.success.withOpacity(0.2)
      //         : AppColors.error.withOpacity(0.2),
      //   ),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey[100]!,
      //       blurRadius: 5,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(isCorrect),
            const SizedBox(height: 12),
            Text(
             question?.question??"",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            _buildAnswerSection(isCorrect),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(bool isCorrect) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.success.withOpacity(0.05)
            : AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Answer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          size: 18,
                          color:
                              isCorrect ? AppColors.success : AppColors.error,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            question?.userAnswer??"",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  isCorrect ? AppColors.success : AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isCorrect) ...[
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct Answer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              
                              question?.correctAnswer??"",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(bool isCorrect) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCorrect
                ? AppColors.success.withOpacity(0.1)
                : AppColors.error.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCorrect ? Icons.check_rounded : Icons.close_rounded,
            color: isCorrect ? AppColors.success : AppColors.error,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Question ${index + 1}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: isCorrect
                ? AppColors.success.withOpacity(0.1)
                : AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isCorrect ? '+1' : '0',
            style: TextStyle(
              color: isCorrect ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
