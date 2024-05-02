import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // AuthRepo authRepo;

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>(authInitialEvent);
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
  }

  FutureOr<void> authInitialEvent(
      AuthInitialEvent event, Emitter<AuthState> emit) {
    // emit(LoginInitialState());
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    bool success = await AuthRepo.LogIn("email", "password");
    if (success) {
      print("success in block");
      emit(LoginSuccessState());
    } else {
      print("gg in block");
      // emit(PostsAdditionErrorState());
    }
  }
}
