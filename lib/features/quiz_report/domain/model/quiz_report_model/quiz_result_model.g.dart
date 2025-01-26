// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResult _$QuestionResultFromJson(Map<String, dynamic> json) =>
    QuestionResult(
      question: json['question'] as String,
      userAnswer: json['userAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      scoredMark: (json['scoredMark'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionResultToJson(QuestionResult instance) =>
    <String, dynamic>{
      'question': instance.question,
      'userAnswer': instance.userAnswer,
      'correctAnswer': instance.correctAnswer,
      'scoredMark': instance.scoredMark,
    };
