import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<RegistrationButtonPressedEvent>(registrationButtonPressedEvent);
    on<AuthInitialEvent>(authInitialEvent);
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

  FutureOr<void> authInitialEvent(
      AuthInitialEvent event, Emitter<AuthState> emit) async {
    try {
      String token = await GetStorage().read("access_token");
      if (token != Null) {
        bool isExpired = JwtDecoder.isExpired(token);
        if (isExpired != true) {
          emit(AuthSuccessState());
        }
      }
    } catch (e) {
      // print(e);
    }
  }
}
