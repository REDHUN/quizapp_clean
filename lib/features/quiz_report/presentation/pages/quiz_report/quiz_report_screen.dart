import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_report_model.dart';
import 'package:game_app/features/quiz_report/presentation/pages/quiz_report/widgets/analysis_section.dart';
import 'package:game_app/features/quiz_report/presentation/pages/quiz_report/widgets/performance_card.dart';
import 'package:game_app/features/quiz_report/presentation/pages/quiz_report/widgets/question_list.dart';
import 'package:game_app/features/quiz_report/presentation/pages/quiz_report/widgets/report_app_bar.dart';



class QuizReportScreen extends StatelessWidget {
 final QuizResultReportModel ? quizResultReportModel;

  const QuizReportScreen({
    super.key,
   this.quizResultReportModel
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkGradient
              : AppColors.primaryGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const ReportAppBar(),
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        PerformanceCard(
                          quizName: quizResultReportModel?.quizName??"",
                          correctAnswers: quizResultReportModel?.score??0,
                          totalQuestions: quizResultReportModel?.questionResults.length??0

                        ),
                        AnalysisSection(
                            correctAnswers: quizResultReportModel?.score??0,
                            totalQuestions: quizResultReportModel?.questionResults.length??0
                        ),
                        QuestionList(
                          questionDetails: quizResultReportModel?.questionResults,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
