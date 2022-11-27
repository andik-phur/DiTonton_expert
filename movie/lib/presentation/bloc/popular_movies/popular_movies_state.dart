part of 'popular_movies_bloc.dart';

abstract class MoviesPopularState extends Equatable {}

class MoviesPopularEmpty extends MoviesPopularState {
  @override
  List<Object?> get props => [];
}

class MoviesPopularLoading extends MoviesPopularState {
  @override
  List<Object?> get props => [];
}

class MoviesPopularError extends MoviesPopularState {
  final String message;

  MoviesPopularError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesPopularHasData extends MoviesPopularState {
  final List<Movie> result;

  MoviesPopularHasData(this.result);

  @override
  List<Object?> get props => [result];
}
