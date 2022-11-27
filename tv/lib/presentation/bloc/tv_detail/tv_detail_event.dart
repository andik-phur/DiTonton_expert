part of 'tv_detail_bloc.dart';

abstract class DetailTvEvent extends Equatable {}

class OnTelevisionDetail extends DetailTvEvent {
  final int id;

  OnTelevisionDetail(this.id);

  @override
  List<Object?> get props => [id];
}
