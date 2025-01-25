// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestionModel _$QuizQuestionModelFromJson(Map<String, dynamic> json) =>
    QuizQuestionModel(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      correctAnswerId: (json['correctAnswerId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      dificaltyName: json['dificaltyName'] as String?,
      questionTypeId: (json['questionTypeId'] as num?)?.toInt(),
      questionTypeName: json['questionTypeName'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      difficultyId: (json['difficultyId'] as num?)?.toInt(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$QuizQuestionModelToJson(QuizQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'correctAnswerId': instance.correctAnswerId,
      'categoryName': instance.categoryName,
      'dificaltyName': instance.dificaltyName,
      'questionTypeId': instance.questionTypeId,
      'questionTypeName': instance.questionTypeName,
      'categoryId': instance.categoryId,
      'difficultyId': instance.difficultyId,
      'options': instance.options,
      'createdBy': instance.createdBy,
      'createdTime': instance.createdTime?.toIso8601String(),
    };
