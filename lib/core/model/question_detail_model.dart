import 'package:json_annotation/json_annotation.dart';
part 'question_detail_model.g.dart';
@JsonSerializable()
class QuestionDetailModel {
  @JsonKey(name: "id")
  int? id;
  String? question;
  int? correctAnswerId;
  String? categoryName;
  String? dificaltyName;
  int? questionTypeId;
  String? questionTypeName;
  dynamic categoryId;
  dynamic difficultyId;
  List<Option>? options;
  String? createdBy;
  DateTime? createdTime;

  QuestionDetailModel({
    this.id,
    this.question,
    this.correctAnswerId,
    this.categoryName,
    this.dificaltyName,
    this.questionTypeId,
    this.questionTypeName,
    this.categoryId,
    this.difficultyId,
    this.options,
    this.createdBy,
    this.createdTime,
  });

  factory QuestionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDetailModelToJson(this);
}
class Option {
  int? id;
  String? text;

  Option({
    this.id,
    this.text,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };
}
