part of 'watchlist_movie_bloc.dart';

abstract class MoviesWatchListState extends Equatable {}

class MoviesWatchListInitial extends MoviesWatchListState {
  @override
  List<Object?> get props => [];
}

class MoviesWatchListEmpty extends MoviesWatchListState {
  @override
  List<Object?> get props => [];
}

class MoviesWatchListLoading extends MoviesWatchListState {
  @override
  List<Object?> get props => [];
}

class MoviesWatchListError extends MoviesWatchListState {
  final String message;

  MoviesWatchListError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesWatchListHasData extends MoviesWatchListState {
  final List<Movie> result;

  MoviesWatchListHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class MoviesWatchListIsAdded extends MoviesWatchListState {
  final bool isAdded;

  MoviesWatchListIsAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class MoviesWatchListMessage extends MoviesWatchListState {
  final String message;

  MoviesWatchListMessage(this.message);

  @override
  List<Object?> get props => [message];
}
