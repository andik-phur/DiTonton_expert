part of 'tv_recommendation_bloc.dart';

abstract class TelevisionRecommendationEvent extends Equatable {}

class OnTelevisionRecommendation extends TelevisionRecommendationEvent {
  final int id;

  OnTelevisionRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}
