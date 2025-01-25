import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: "password")
  String? password;
  bool? enabled;
  List<Authority>? authorities;
  String? username;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? accountNonLocked;
  int? userId;

  UserModel({
    this.password,
    this.enabled,
    this.authorities,
    this.username,
    this.credentialsNonExpired,
    this.accountNonExpired,
    this.accountNonLocked,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        password,
        enabled,
        authorities,
        username,
        credentialsNonExpired,
        accountNonExpired,
        accountNonLocked,
        userId,
      ];
}

class Authority {
  String? authority;

  Authority({
    this.authority,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authority: json["authority"],
      );

  Map<String, dynamic> toJson() => {
        "authority": authority,
      };
}
