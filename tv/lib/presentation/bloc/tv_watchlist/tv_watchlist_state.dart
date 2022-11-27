part of 'tv_watchlist_bloc.dart';

abstract class TelevisionWatchListState extends Equatable {}

class TelevisionWatchListInitial extends TelevisionWatchListState {
  @override
  List<Object?> get props => [];
}

class TelevisionWatchListEmpty extends TelevisionWatchListState {
  @override
  List<Object?> get props => [];
}

class TelevisionWatchListLoading extends TelevisionWatchListState {
  @override
  List<Object?> get props => [];
}

class TelevisionWatchListError extends TelevisionWatchListState {
  final String message;

  TelevisionWatchListError(this.message);

  @override
  List<Object?> get props => [message];
}

class TelevisionWatchListHasData extends TelevisionWatchListState {
  final List<Television> result;

  TelevisionWatchListHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TelevisionWatchListIsAdded extends TelevisionWatchListState {
  final bool isAdded;

  TelevisionWatchListIsAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class TelevisionWatchListMessage extends TelevisionWatchListState {
  final String message;

  TelevisionWatchListMessage(this.message);

  @override
  List<Object?> get props => [message];
}
