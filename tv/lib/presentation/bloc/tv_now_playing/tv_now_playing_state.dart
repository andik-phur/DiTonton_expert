part of 'tv_now_playing_bloc.dart';

abstract class TvOnTheAirState extends Equatable {}

class TvOnTheAirEmpty extends TvOnTheAirState {
  @override
  List<Object?> get props => [];
}

class TvOnTheAirLoading extends TvOnTheAirState {
  @override
  List<Object?> get props => [];
}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  TvOnTheAirError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvOnTheAirHasData extends TvOnTheAirState {
  final List<Television> result;

  TvOnTheAirHasData(this.result);

  @override
  List<Object?> get props => [result];
}
