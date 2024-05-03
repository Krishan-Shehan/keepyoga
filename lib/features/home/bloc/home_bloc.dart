import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:keepyoga/features/home/models/Yoga_Session_DataModel.dart';
import 'package:keepyoga/features/home/repo/yoga_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeYogaSessionButtonClickedEvent>(homeYogaSessionButtonClickedEvent);
    on<HomeLogOutButtonClickedEvent>(homeLogOutButtonClickedEvent);
  }

  Future<FutureOr<void>> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeYogaSessionsLoadingState());
    try {
      String token = await GetStorage().read("access_token");
      if (token != Null) {
        bool isExpired = JwtDecoder.isExpired(token);
        if (isExpired == true) {
          emit(HometokenExpiredState());
        } else {
          List<YogaSessionData> yogaSessions =
              await YogaRepo.fetchYogaSessions();
          emit(HomeYogaSessionsLoadedSuccessState(YogaSession: yogaSessions));
        }
      } else {
        emit(HometokenExpiredState());
      }
    } catch (e) {
      emit(HometokenExpiredState());
    }
  }

  FutureOr<void> homeYogaSessionButtonClickedEvent(
      HomeYogaSessionButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeYogaSessionSelecttedState(
        YogaSessionId: event.clickedYogaSessionId));
  }

  FutureOr<void> homeLogOutButtonClickedEvent(
      HomeLogOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    await GetStorage().remove("access_token");
    emit(HomeLogOutState());
  }
}
