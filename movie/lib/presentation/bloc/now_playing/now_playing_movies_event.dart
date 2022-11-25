part of 'now_playing_movies_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {}

class OnMovieNowPLayingCalled extends MovieNowPlayingEvent {
  @override
  List<Object?> get props => [];
}
