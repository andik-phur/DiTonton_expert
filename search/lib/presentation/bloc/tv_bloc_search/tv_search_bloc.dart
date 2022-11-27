// ignore_for_file: depend_on_referenced_packages

import 'package:tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchBlocTv extends Bloc<SearchEvent, TvSearchState> {
  final TvSearch _searchtv;

  SearchBlocTv(this._searchtv) : super(SearchEmptyTv()) {
    on<OnQueryTvChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchtv.execute(query);
      result.fold((failure) {
        emit(SearchTvError(failure.message));
      }, (success) {
        emit(SearchTvHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
