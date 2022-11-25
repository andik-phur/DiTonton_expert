part of 'tv_watchlist_bloc.dart';

abstract class TvWatchListState extends Equatable {}

class TvWatchListInitial extends TvWatchListState {
  @override
  List<Object?> get props => [];
}

class TvWatchListEmpty extends TvWatchListState {
  @override
  List<Object?> get props => [];
}

class TvWatchListLoading extends TvWatchListState {
  @override
  List<Object?> get props => [];
}

class TvWatchListError extends TvWatchListState {
  final String message;

  TvWatchListError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvWatchListHasData extends TvWatchListState {
  final List<Television> result;

  TvWatchListHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvWatchListIsAdded extends TvWatchListState {
  final bool isAdded;

  TvWatchListIsAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class TvWatchListMessage extends TvWatchListState {
  final String message;

  TvWatchListMessage(this.message);

  @override
  List<Object?> get props => [message];
}
