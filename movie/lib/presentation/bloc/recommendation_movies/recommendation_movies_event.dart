part of 'recommendation_movies_bloc.dart';

abstract class MoviesRecommendationEvent extends Equatable {}

class OnMoviesRecommendation extends MoviesRecommendationEvent {
  final int id;

  OnMoviesRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}
