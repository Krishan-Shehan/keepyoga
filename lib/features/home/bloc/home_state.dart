part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeYogaSessionsLoadingState extends HomeState {}

class HomeYogaSessionsLoadedSuccessState extends HomeState {
  final List<YogaSessionData> YogaSession;
  HomeYogaSessionsLoadedSuccessState({
    required this.YogaSession,
  });
}

class HomeYogaSessionSelecttedState extends HomeActionState {
  final String YogaSessionId;
  HomeYogaSessionSelecttedState({required this.YogaSessionId});
}
