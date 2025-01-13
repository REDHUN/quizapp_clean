import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user_model.dart';


enum UserStatus {
  initial,
  loading,
  success,
  error,
}

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;

  final String? userToken;
  final UserModel? userModel;

  const UserState._({required this.status, this.userToken, this.errorMessage,this.userModel});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith(
      {UserStatus? status, String? userToken, String? errorMessage,UserModel ? userModel}) {
    return UserState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        userToken: userToken ?? this.userToken,userModel: userModel?? this.userModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[status,errorMessage,userModel];
}
