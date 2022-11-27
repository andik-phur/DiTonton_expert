part of 'tv_watchlist_bloc.dart';

abstract class TelevisionWatchListEvent extends Equatable {}

class OnFetchTelevisionWatchList extends TelevisionWatchListEvent {
  @override
  List<Object?> get props => [];
}

class TelevisionWatchListStatus extends TelevisionWatchListEvent {
  final int id;

  TelevisionWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class TelevisionWatchListAdd extends TelevisionWatchListEvent {
  final TvDetail tvDetail;

  TelevisionWatchListAdd(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class TelevisionWatchListRemove extends TelevisionWatchListEvent {
  final TvDetail tvDetail;

  TelevisionWatchListRemove(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}
