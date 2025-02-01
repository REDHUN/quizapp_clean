import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: "id")
  int? id;
  String? username;
  String? password;
  String? email;
  List<String>? roles;
  bool? enabled;
  int? totalScore;
  List<String>? badges;


  UserModel({
    this.id,
    this.username,
    this.password,
    this.email,
    this.roles,
    this.enabled,
    this.totalScore,
    this.badges,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        password,
        enabled,
    totalScore,
    badges,roles,id,email,
        username,

      ];
}


