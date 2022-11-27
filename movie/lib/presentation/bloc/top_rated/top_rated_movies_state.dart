part of 'top_rated_movies_bloc.dart';

abstract class MoviesTopRatedState extends Equatable {}

class MoviesTopRatedEmpty extends MoviesTopRatedState {
  @override
  List<Object?> get props => [];
}

class MoviesTopRatedLoading extends MoviesTopRatedState {
  @override
  List<Object?> get props => [];
}

class MoviesTopRatedError extends MoviesTopRatedState {
  final String message;

  MoviesTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesTopRatedHasData extends MoviesTopRatedState {
  final List<Movie> result;

  MoviesTopRatedHasData(this.result);

  @override
  List<Object?> get props => [result];
}
