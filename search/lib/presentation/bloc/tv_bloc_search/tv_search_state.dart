part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object?> get props => [];
}

class SearchEmptyTv extends TvSearchState {}

class SearchTvLoading extends TvSearchState {}

class SearchTvError extends TvSearchState {
  final String message;

  const SearchTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvHasData extends TvSearchState {
  final List<Television> result;

  const SearchTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}
