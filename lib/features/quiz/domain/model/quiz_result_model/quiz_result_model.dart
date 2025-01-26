import 'package:json_annotation/json_annotation.dart';
part 'quiz_result_model.g.dart';


@JsonSerializable()

class QuizResultModel {
  @JsonKey(name: "quizIdd")
  int? userId;
  int? quizId;
  String? quizName;
  int? score;
  int? totalQuestions;

  QuizResultModel({
    this.userId,
    this.quizId,
    this.quizName,
    this.score,
    this.totalQuestions,
  });
  factory QuizResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultModelToJson(this);

}