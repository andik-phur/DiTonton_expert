part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {}

class OnTvDetail extends TvDetailEvent {
  final int id;

  OnTvDetail(this.id);

  @override
  List<Object?> get props => [id];
}
