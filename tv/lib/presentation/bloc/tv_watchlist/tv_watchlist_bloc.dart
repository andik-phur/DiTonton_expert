// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_tv_watcha_list.dart';
import 'package:core/domain/usecases/get_watch_list_status_tv.dart';
import 'package:core/domain/usecases/remove_tv_watch_list.dart';
import 'package:core/domain/usecases/save_tv_watch_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TvWatchListBloc extends Bloc<TvWatchListEvent, TvWatchListState> {
  final GetTvWatchlist _getWatchlistTv;
  final GetTvWatchlistStatus _getWatchlistStatusTv;
  final RemoveTvWatchlist _removeWatchlistTv;
  final SaveTvWatchlist _saveWatchlistTv;

  TvWatchListBloc(this._getWatchlistTv, this._getWatchlistStatusTv,
      this._removeWatchlistTv, this._saveWatchlistTv)
      : super(TvWatchListInitial()) {
    on<OnFetchTvWatchList>(_onFetchTvWatchList);
    on<TvWatchListStatus>(_onTvWatchListStatus);
    on<TvWatchListAdd>(_onTvWatchListAdd);
    on<TvWatchListRemove>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchTvWatchList(
      OnFetchTvWatchList event, Emitter<TvWatchListState> emit) async {
    emit(TvWatchListLoading());
    final result = await _getWatchlistTv.execute();
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvWatchListEmpty())
          : emit(TvWatchListHasData(success));
    });
  }

  FutureOr<void> _onTvWatchListStatus(
      TvWatchListStatus event, Emitter<TvWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchlistStatusTv.execute(id);
    emit(TvWatchListIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(
      TvWatchListAdd event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _saveWatchlistTv.execute(tv);
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(
      TvWatchListRemove event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _removeWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }
}
