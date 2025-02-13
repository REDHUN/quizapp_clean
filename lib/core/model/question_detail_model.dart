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
  List<Options>? options;
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
class Options {
  int? id;
  String? text;

  Options({
    this.id,
    this.text,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };
}
