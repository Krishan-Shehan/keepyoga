part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class HomeYogaSessionButtonClickedEvent extends HomeEvent {
  final YogaSessionData clickedYogaSession;
  HomeYogaSessionButtonClickedEvent({
    required this.clickedYogaSession,
  });
}
