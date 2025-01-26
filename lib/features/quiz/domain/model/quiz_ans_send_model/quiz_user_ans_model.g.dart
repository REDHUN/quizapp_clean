// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_user_ans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) => UserAnswer(
      questionId: (json['questionId'] as num?)?.toInt(),
      userAnswer: (json['userAnswer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserAnswerToJson(UserAnswer instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'userAnswer': instance.userAnswer,
    };
