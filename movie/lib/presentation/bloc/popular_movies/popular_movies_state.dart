part of 'popular_movies_bloc.dart';

abstract class MoviePopularState extends Equatable {}

class MoviePopularEmpty extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class MoviePopularLoading extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  MoviePopularError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> result;

  MoviePopularHasData(this.result);

  @override
  List<Object?> get props => [result];
}
