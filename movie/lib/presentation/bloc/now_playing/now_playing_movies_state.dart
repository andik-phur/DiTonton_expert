part of 'now_playing_movies_bloc.dart';

abstract class MoviesNowPlayingState extends Equatable {
  const MoviesNowPlayingState();

  @override
  List<Object?> get props => [];
}

class MoviesNowPlayingEmpty extends MoviesNowPlayingState {}

class MoviesNowPlayingLoading extends MoviesNowPlayingState {}

class MoviesNowPlayingError extends MoviesNowPlayingState {
  final String message;

  const MoviesNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesNowPlayingHasData extends MoviesNowPlayingState {
  final List<Movie> result;

  const MoviesNowPlayingHasData(this.result);

  @override
  List<Object?> get props => [result];
}
