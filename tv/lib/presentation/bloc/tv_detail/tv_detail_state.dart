part of 'tv_detail_bloc.dart';

abstract class DetailTvState extends Equatable {}

class TelevisionDetailEmpty extends DetailTvState {
  @override
  List<Object?> get props => [];
}

class TelevisionDetailLoading extends DetailTvState {
  @override
  List<Object?> get props => [];
}

class TelevisionDetailError extends DetailTvState {
  final String message;

  TelevisionDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailTvHasData extends DetailTvState {
  final TvDetail result;

  DetailTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}
