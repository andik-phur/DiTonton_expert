part of "movie_detail_bloc.dart";

abstract class MoviesDetailState extends Equatable {}

class MoviesDetailEmpty extends MoviesDetailState {
  @override
  List<Object?> get props => [];
}

class MoviesDetailLoading extends MoviesDetailState {
  @override
  List<Object?> get props => [];
}

class MoviesDetailError extends MoviesDetailState {
  final String message;

  MoviesDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesDetailHasData extends MoviesDetailState {
  final MovieDetail result;

  MoviesDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
