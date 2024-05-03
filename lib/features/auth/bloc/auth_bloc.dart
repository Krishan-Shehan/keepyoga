import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<RegistrationButtonPressedEvent>(registrationButtonPressedEvent);
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    bool success = await AuthRepo.LogIn(event.email, event.password);
    if (success) {
      print("success Login");
      emit(LoginSuccessState());
    } else {
      print("LoginErrorState");
      emit(LoginErrorState());
    }
  }

  FutureOr<void> registrationButtonPressedEvent(
      RegistrationButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(RegistrationLoadingState());
    bool success = await AuthRepo.Register(
        event.email, event.password, event.username, event.gender);
    if (success) {
      emit(RegistrationSuccessState());
    } else {
      emit(RegistrationErrorState());
    }
  }
}
