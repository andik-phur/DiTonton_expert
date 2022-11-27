part of 'watchlist_movie_bloc.dart';

abstract class MoviesWatchListEvent extends Equatable {}

class OnFetchMoviesWatchList extends MoviesWatchListEvent {
  @override
  List<Object?> get props => [];
}

class MoviesWatchListStatus extends MoviesWatchListEvent {
  final int id;

  MoviesWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class MoviesWatchListAdd extends MoviesWatchListEvent {
  final MovieDetail movieDetail;

  MoviesWatchListAdd(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MoviesWatchListRemove extends MoviesWatchListEvent {
  final MovieDetail movieDetail;

  MoviesWatchListRemove(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}
