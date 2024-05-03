import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:keepyoga/features/home/models/Yoga_Session_DataModel.dart';
import 'package:keepyoga/features/home/repo/yoga_repo.dart';
import 'package:meta/meta.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<LessonInitialFetchEvent>(lessonInitialFetchEvent);
    on<LessonYogaButtonClickedEvent>(lessonYogaButtonClickedEvent);
    on<LessonYogaBackButtonClickedEvent>(lessonYogaBackButtonClickedEvent);
  }

  Future<FutureOr<void>> lessonInitialFetchEvent(
      LessonInitialFetchEvent event, Emitter<LessonState> emit) async {
    emit(LessonYogaLoadingState());

    List<YogaSessionData> yogaSession =
        await YogaRepo.fetchYogaSingleSessionData(event.yogaSessionId);

    emit(LessonYogaLoadedSuccessState(YogaSession: yogaSession));
  }

  FutureOr<void> lessonYogaButtonClickedEvent(
      LessonYogaButtonClickedEvent event, Emitter<LessonState> emit) {
    emit(LessonYogaSelecttedLesson(YogaLessonId: event.clickedYogaLessonId));
  }

  FutureOr<void> lessonYogaBackButtonClickedEvent(
      LessonYogaBackButtonClickedEvent event, Emitter<LessonState> emit) {
    emit(LessonYogaGoBackActionState());
  }
}
