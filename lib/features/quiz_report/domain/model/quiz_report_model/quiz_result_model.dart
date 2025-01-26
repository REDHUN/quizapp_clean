
import 'package:json_annotation/json_annotation.dart';
part 'quiz_result_model.g.dart';
@JsonSerializable()
class QuestionResult {
  @JsonKey(name: "question")
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final int scoredMark;

  QuestionResult({
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.scoredMark,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) =>
      _$QuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResultToJson(this);
}