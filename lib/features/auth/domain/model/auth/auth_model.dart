
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';
@JsonSerializable()
class AuthModel extends Equatable {
  @JsonKey(name: "userId")
 final String? userId;
 final String? token;



 const AuthModel({this.userId, this.token});
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>[userId,token];
}
