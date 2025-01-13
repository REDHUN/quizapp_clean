import 'package:game_app/core/storage/shared_prefs.dart';
import 'package:game_app/features/auth/domain/repository/auth_repository.dart';
import 'package:game_app/features/auth/domain/repository/user_respository.dart';
import 'package:game_app/features/auth/presentation/bloc/user_event.dart';
import 'package:game_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository, required this.userRepository})
      : super(UserState.initial()) {
    on<LoginWithPassowordEvent>(onLoginWithUserPasswordEvent);
    on<GetUserDetailsEvent>(onGetUserDetailsEvent);
    on<UserLogoutEvent>(onUserLogoutEvent);
  }

  Future onLoginWithUserPasswordEvent(
      LoginWithPassowordEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await authRepository.loginWithUserPassword(
        username: event.username, password: event.password);

    if (data.isRight()) {
      // Emit success state with user token


      // Call onGetUserDetailsEvent after successful login
      var userDetailsEvent = GetUserDetailsEvent(username: event.username);
      await onGetUserDetailsEvent(userDetailsEvent, emit);

    //  emit(state.copyWith(status: UserStatus.success, userToken: data.right));

    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  Future onGetUserDetailsEvent(GetUserDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await userRepository.getUser(
      userName: event.username,
    );

    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }


  Future<void> onUserLogoutEvent(
      UserLogoutEvent event, Emitter<UserState> emit) async {
    try {
      await SharedPrefs.clearUserData();
      emit(UserState.initial());
    } catch (e) {
      emit(
          state.copyWith(status: UserStatus.error, errorMessage: e.toString()));
    }
  }
}
