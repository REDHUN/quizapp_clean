import 'package:json_annotation/json_annotation.dart';

part 'difficulty_model.g.dart';

@JsonSerializable()
class DifficultyModel {
  @JsonKey(name: "id")
  int? id;
  String? name;

  DifficultyModel({
    this.id,
    this.name,
  });

  factory DifficultyModel.fromJson(Map<String, dynamic> json) =>
      _$DifficultyModelFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyModelToJson(this);
}