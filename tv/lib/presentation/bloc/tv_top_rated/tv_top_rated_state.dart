part of 'tv_top_rated_bloc.dart';

abstract class TelevisionTopRatedState extends Equatable {}

class TelevisionTopRatedEmpty extends TelevisionTopRatedState {
  @override
  List<Object?> get props => [];
}

class TelevisionTopRatedLoading extends TelevisionTopRatedState {
  @override
  List<Object?> get props => [];
}

class TelevisionTopRatedError extends TelevisionTopRatedState {
  final String message;

  TelevisionTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class TelevisionTopRatedHasData extends TelevisionTopRatedState {
  final List<Television> result;

  TelevisionTopRatedHasData(this.result);

  @override
  List<Object?> get props => [result];
}
