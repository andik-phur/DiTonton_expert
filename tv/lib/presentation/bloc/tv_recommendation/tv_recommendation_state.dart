part of 'tv_recommendation_bloc.dart';

abstract class TelevisionRecommendationState extends Equatable {}

class TelevisionRecommendationEmpty extends TelevisionRecommendationState {
  @override
  List<Object?> get props => [];
}

class TelevisionRecommendationLoading extends TelevisionRecommendationState {
  @override
  List<Object?> get props => [];
}

class TelevisionRecommendationError extends TelevisionRecommendationState {
  final String message;

  TelevisionRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class TelevisionRecommendationHasData extends TelevisionRecommendationState {
  final List<Television> result;

  TelevisionRecommendationHasData(this.result);

  @override
  List<Object?> get props => [result];
}
