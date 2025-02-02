import 'package:json_annotation/json_annotation.dart';

part 'question_type_model.g.dart';

@JsonSerializable()
class QuestionTypeModel {
  @JsonKey(name: "id")
  int? id;
  String? name;

  QuestionTypeModel({
    this.id,
    this.name,
  });

  factory QuestionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionTypeModelToJson(this);
}