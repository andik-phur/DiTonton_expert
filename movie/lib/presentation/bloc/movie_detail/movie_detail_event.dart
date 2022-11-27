part of "movie_detail_bloc.dart";

abstract class MoviesDetailEvent extends Equatable {}

class OnMoviesDetail extends MoviesDetailEvent {
  final int id;

  OnMoviesDetail(this.id);

  @override
  List<Object?> get props => [id];
}
