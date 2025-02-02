// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionTypeModel _$QuestionTypeModelFromJson(Map<String, dynamic> json) =>
    QuestionTypeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$QuestionTypeModelToJson(QuestionTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
