part of 'recommendation_movies_bloc.dart';

@immutable
abstract class MoviesRecommendationState extends Equatable {}

class MoviesRecommendationEmpty extends MoviesRecommendationState {
  @override
  List<Object?> get props => [];
}

class MoviesRecommendationLoading extends MoviesRecommendationState {
  @override
  List<Object?> get props => [];
}

class MoviesRecommendationError extends MoviesRecommendationState {
  final String message;

  MoviesRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviesRecommendationHasData extends MoviesRecommendationState {
  final List<Movie> result;

  MoviesRecommendationHasData(this.result);

  @override
  List<Object?> get props => [result];
}
