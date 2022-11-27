part of 'tv_popular_bloc.dart';

abstract class TelevisionPopularState extends Equatable {}

class TelevisionPopularEmpty extends TelevisionPopularState {
  @override
  List<Object?> get props => [];
}

class TelevisionPopularLoading extends TelevisionPopularState {
  @override
  List<Object?> get props => [];
}

class TelevisionPopularError extends TelevisionPopularState {
  final String message;

  TelevisionPopularError(this.message);

  @override
  List<Object?> get props => [message];
}

class TelevisionPopularHasData extends TelevisionPopularState {
  final List<Television> result;

  TelevisionPopularHasData(this.result);

  @override
  List<Object?> get props => [result];
}
