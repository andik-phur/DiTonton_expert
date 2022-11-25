// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/usecase/search_movies.dart';

part 'search_movie_state.dart';
part 'search_movie_event.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovie;

  SearchBloc(this._searchMovie) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovie.execute(query);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (success) {
        emit(SearchHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
