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
