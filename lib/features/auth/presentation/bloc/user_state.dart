import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';

enum UserStatus { initial, loading, success, error, userLogoutSuccess }

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;
  final List<String>? userRoles;
  final bool isAdmin;

  final String? userToken;
  final UserModel? userModel;

  const UserState._(
      {required this.status,
      this.userRoles,
      this.isAdmin = false,
      this.userToken,
      this.errorMessage,
      this.userModel});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith(
      {UserStatus? status,
      String? userToken,
      String? errorMessage,
      UserModel? userModel,
      bool? isAdmin,
      List<String>? userRoles}) {
    return UserState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        userToken: userToken ?? this.userToken,
        userModel: userModel ?? this.userModel,
        isAdmin: isAdmin ?? this.isAdmin,
        userRoles: userRoles ?? this.userRoles);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessage, userModel,isAdmin,userRoles];
}
