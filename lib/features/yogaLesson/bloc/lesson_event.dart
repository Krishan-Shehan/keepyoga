part of 'lesson_bloc.dart';

@immutable
sealed class LessonEvent {}

class LessonInitialFetchEvent extends LessonEvent {
  final String yogaSessionId;
  LessonInitialFetchEvent({
    required this.yogaSessionId,
  });
}

class LessonYogaButtonClickedEvent extends LessonEvent {
  final String clickedYogaLessonId;
  LessonYogaButtonClickedEvent({
    required this.clickedYogaLessonId,
  });
}
