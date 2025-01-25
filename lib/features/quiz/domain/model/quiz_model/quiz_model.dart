import 'package:json_annotation/json_annotation.dart';
part 'quiz_model.g.dart';


@JsonSerializable()

class QuizModel {
  @JsonKey(name: "id")
  int? id;
  String? title;
  List<int>? questionIds;
  int? totalQuestions;
  String? description;

  QuizModel({
    this.id,
    this.title,
    this.questionIds,
    this.totalQuestions,
    this.description,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

}