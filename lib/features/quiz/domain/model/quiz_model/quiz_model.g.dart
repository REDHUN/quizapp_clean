// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      questionIds: (json['questionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      totalQuestions: (json['totalQuestions'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questionIds': instance.questionIds,
      'totalQuestions': instance.totalQuestions,
      'description': instance.description,
    };
