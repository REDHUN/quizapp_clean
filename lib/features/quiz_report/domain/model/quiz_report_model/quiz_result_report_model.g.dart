// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResultReportModel _$QuizResultReportModelFromJson(
        Map<String, dynamic> json) =>
    QuizResultReportModel(
      userId: (json['userId'] as num).toInt(),
      quizId: (json['quizId'] as num).toInt(),
      resultId: (json['resultId'] as num).toInt(),
      quizName: json['quizName'] as String,
      score: (json['score'] as num).toInt(),
      questionResults: (json['questionResults'] as List<dynamic>)
          .map((e) => QuestionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizResultReportModelToJson(
        QuizResultReportModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'quizId': instance.quizId,
      'resultId': instance.resultId,
      'quizName': instance.quizName,
      'score': instance.score,
      'questionResults': instance.questionResults,
    };
