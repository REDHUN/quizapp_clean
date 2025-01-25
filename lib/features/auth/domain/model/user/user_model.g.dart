// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      password: json['password'] as String?,
      enabled: json['enabled'] as bool?,
      authorities: (json['authorities'] as List<dynamic>?)
          ?.map((e) => Authority.fromJson(e as Map<String, dynamic>))
          .toList(),
      username: json['username'] as String?,
      credentialsNonExpired: json['credentialsNonExpired'] as bool?,
      accountNonExpired: json['accountNonExpired'] as bool?,
      accountNonLocked: json['accountNonLocked'] as bool?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'password': instance.password,
      'enabled': instance.enabled,
      'authorities': instance.authorities,
      'username': instance.username,
      'credentialsNonExpired': instance.credentialsNonExpired,
      'accountNonExpired': instance.accountNonExpired,
      'accountNonLocked': instance.accountNonLocked,
      'userId': instance.userId,
    };
