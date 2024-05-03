part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class RegistrationLoadingState extends AuthState {}

class RegistrationSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

class RegistrationErrorState extends AuthState {}

class AuthSuccessState extends AuthState {}
