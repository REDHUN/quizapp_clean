// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResultModel _$QuizResultModelFromJson(Map<String, dynamic> json) =>
    QuizResultModel(
      userId: (json['quizIdd'] as num?)?.toInt(),
      quizId: (json['quizId'] as num?)?.toInt(),
      quizName: json['quizName'] as String?,
      score: (json['score'] as num?)?.toInt(),
      totalQuestions: (json['totalQuestions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuizResultModelToJson(QuizResultModel instance) =>
    <String, dynamic>{
      'quizIdd': instance.userId,
      'quizId': instance.quizId,
      'quizName': instance.quizName,
      'score': instance.score,
      'totalQuestions': instance.totalQuestions,
    };
