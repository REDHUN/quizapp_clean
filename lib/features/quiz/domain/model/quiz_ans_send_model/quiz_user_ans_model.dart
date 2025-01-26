import 'package:json_annotation/json_annotation.dart';
part 'quiz_user_ans_model.g.dart';

@JsonSerializable()
class UserAnswer {
  @JsonKey(name: "questionId")
  int? questionId;
  int? userAnswer;

  UserAnswer({
    this.questionId,
    this.userAnswer,
  });

  factory UserAnswer.fromJson(Map<String, dynamic> json) => UserAnswer(
    questionId: json["questionId"],
    userAnswer: json["userAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "userAnswer": userAnswer,
  };
  // factory QuizAnsSendModel.fromJson(Map<String, dynamic> json) =>
  //     _$QuizAnsSendModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$QuizAnsSendModelToJson(this);
}