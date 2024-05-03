part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {}

class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressedEvent({required this.email, required this.password});
}

class RegistrationButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  final String gender;
  final String username;
  RegistrationButtonPressedEvent(
      {required this.email,
      required this.password,
      required this.gender,
      required this.username});
}
