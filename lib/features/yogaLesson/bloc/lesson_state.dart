part of 'lesson_bloc.dart';

@immutable
sealed class LessonState {}

sealed class LessonActionState extends LessonState {}

final class LessonInitial extends LessonState {}

class LessonYogaLoadingState extends LessonState {}

class LessonYogaLoadedSuccessState extends LessonState {
  final List<YogaSessionData> YogaSession;
  LessonYogaLoadedSuccessState({
    required this.YogaSession,
  });
}

class LessonYogaSelecttedLesson extends LessonActionState {
  final String YogaLessonId;
  LessonYogaSelecttedLesson({required this.YogaLessonId});
}

class LessonYogaGoBackActionState extends LessonActionState {}
