part of 'single_lesson_bloc.dart';

@immutable
sealed class SingleLessonEvent {}

class SingleLessonInitialFetchEvent extends SingleLessonEvent {
  final String yogaLessonId;
  SingleLessonInitialFetchEvent({
    required this.yogaLessonId,
  });
}
