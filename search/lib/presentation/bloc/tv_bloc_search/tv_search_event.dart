part of 'tv_search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryTvChanged extends SearchEvent {
  final String query;

  const OnQueryTvChanged(this.query);

  @override
  List<Object?> get props => [query];
}
