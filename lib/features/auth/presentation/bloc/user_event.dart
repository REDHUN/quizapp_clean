abstract class UserEvent {}

class LoginWithPassowordEvent extends UserEvent {
  final String username;
  final String password;

  LoginWithPassowordEvent({required this.username, required this.password});
}

class GetUserDetailsEvent extends UserEvent {
  final String username;

  GetUserDetailsEvent({required this.username});
}

class UserLogoutEvent extends UserEvent {
  UserLogoutEvent();
}
