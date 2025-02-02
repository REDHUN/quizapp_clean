// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DifficultyModel _$DifficultyModelFromJson(Map<String, dynamic> json) =>
    DifficultyModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DifficultyModelToJson(DifficultyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
