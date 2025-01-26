
import 'package:game_app/features/quiz_report/domain/model/quiz_report_model/quiz_result_model.dart';

import 'package:json_annotation/json_annotation.dart';
part 'quiz_result_report_model.g.dart';
@JsonSerializable()
class QuizResultReportModel {
  @JsonKey(name: "userId")
  final int userId;
  final int quizId;
  final int resultId;
  final String quizName;
  final int score;
  final List<QuestionResult> questionResults;

  QuizResultReportModel({
    required this.userId,
    required this.quizId,
    required this.resultId,
    required this.quizName,
    required this.score,
    required this.questionResults,
  });
  factory QuizResultReportModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultReportModelToJson(this);
}

