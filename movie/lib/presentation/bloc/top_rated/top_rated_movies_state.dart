part of 'top_rated_movies_bloc.dart';

abstract class MovieTopRatedState extends Equatable {}

class MovieTopRatedEmpty extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  MovieTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  List<Object?> get props => [result];
}
