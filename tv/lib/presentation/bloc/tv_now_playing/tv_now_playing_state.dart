part of 'tv_now_playing_bloc.dart';

abstract class TelevisionOnTheAirState extends Equatable {}

class TelevisionOnTheAirEmpty extends TelevisionOnTheAirState {
  @override
  List<Object?> get props => [];
}

class TelevisionOnTheAirLoading extends TelevisionOnTheAirState {
  @override
  List<Object?> get props => [];
}

class TelevisionOnTheAirError extends TelevisionOnTheAirState {
  final String message;

  TelevisionOnTheAirError(this.message);

  @override
  List<Object?> get props => [message];
}

class TelevisionOnTheAirHasData extends TelevisionOnTheAirState {
  final List<Television> result;

  TelevisionOnTheAirHasData(this.result);

  @override
  List<Object?> get props => [result];
}
