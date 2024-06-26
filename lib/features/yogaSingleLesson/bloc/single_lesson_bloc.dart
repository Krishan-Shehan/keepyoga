import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:keepyoga/features/home/models/Yoga_Session_DataModel.dart';
import 'package:keepyoga/features/home/repo/yoga_repo.dart';
import 'package:meta/meta.dart';

part 'single_lesson_event.dart';
part 'single_lesson_state.dart';

class SingleLessonBloc extends Bloc<SingleLessonEvent, SingleLessonState> {
  SingleLessonBloc() : super(SingleLessonInitial()) {
    on<SingleLessonInitialFetchEvent>(singleLessonInitialFetchEvent);
    on<SingleLessonYogaBackButtonClickedEvent>(
        singleLessonYogaBackButtonClickedEvent);
    on<PlayVidoEvent>(playVidoEvent);
  }

  FutureOr<void> singleLessonInitialFetchEvent(
      SingleLessonInitialFetchEvent event,
      Emitter<SingleLessonState> emit) async {
    emit(SingleLessonYogaLoadingState());
    List<YogaSessionLessonData> yogaLesson =
        await YogaRepo.fetchYogaSingleLessonData(event.yogaLessonId);
    print(yogaLesson);
    emit(SingleLessonYogaLoadedSuccessState(YogaLesson: yogaLesson));
  }

  FutureOr<void> singleLessonYogaBackButtonClickedEvent(
      SingleLessonYogaBackButtonClickedEvent event,
      Emitter<SingleLessonState> emit) {
    emit(SingleLessonYogaSelectedSession(
        YogaSessionId: event.clickedYogaSessionId));
  }

  FutureOr<void> playVidoEvent(
      PlayVidoEvent event, Emitter<SingleLessonState> emit) {
    emit(PlayVideoState());
  }
}
