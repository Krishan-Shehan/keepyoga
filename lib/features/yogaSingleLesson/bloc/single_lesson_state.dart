part of 'single_lesson_bloc.dart';

@immutable
sealed class SingleLessonState {}

sealed class SingleLessonActionState extends SingleLessonState {}

final class SingleLessonInitial extends SingleLessonState {}

class SingleLessonYogaLoadingState extends SingleLessonState {}

class SingleLessonYogaLoadedSuccessState extends SingleLessonState {
  final List<YogaSessionLessonData> YogaLesson;
  SingleLessonYogaLoadedSuccessState({
    required this.YogaLesson,
  });
}
