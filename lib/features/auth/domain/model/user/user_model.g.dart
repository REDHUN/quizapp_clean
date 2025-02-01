// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      enabled: json['enabled'] as bool?,
      totalScore: (json['totalScore'] as num?)?.toInt(),
      badges:
          (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'roles': instance.roles,
      'enabled': instance.enabled,
      'totalScore': instance.totalScore,
      'badges': instance.badges,
    };
