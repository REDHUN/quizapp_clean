import 'package:equatable/equatable.dart';
import 'package:game_app/features/auth/domain/model/user/user_model.dart';

enum CreateQuizStatus { initial, loading, success, error, }

class CreateQuizState extends Equatable {
  final CreateQuizStatus status;
  final String? errorMessage;


  const CreateQuizState._(
      {required this.status,
        this.errorMessage,
       });

  factory CreateQuizState.initial() => CreateQuizState._(status: CreateQuizStatus.initial);

  CreateQuizState copyWith(
      {CreateQuizStatus? status,
        String? userToken,
        String? errorMessage,
        UserModel? userModel,
        bool? isAdmin,
        List<String>? userRoles}) {
    return CreateQuizState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessage,];
}
