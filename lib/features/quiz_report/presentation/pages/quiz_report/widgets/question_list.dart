import 'package:flutter/material.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_model.dart';

import 'question_item.dart';

class QuestionList extends StatelessWidget {
final List<QuestionResult> ?  questionDetails;

  const QuestionList({
    super.key,
   this.questionDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Question Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questionDetails?.length??0,
            itemBuilder: (context, index) => QuestionItem(
              question: questionDetails?[index],
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}
