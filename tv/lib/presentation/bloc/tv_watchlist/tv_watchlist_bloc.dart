// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_watcha_list.dart';
import 'package:tv/domain/usecases/get_watch_list_status_tv.dart';
import 'package:tv/domain/usecases/remove_tv_watch_list.dart';
import 'package:tv/domain/usecases/save_tv_watch_list.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TelevisionWatchListBloc
    extends Bloc<TelevisionWatchListEvent, TelevisionWatchListState> {
  final GetTvWatchlist _getWatchlistTv;
  final GetTvWatchlistStatus _getWatchlistStatusTv;
  final RemoveTvWatchlist _removeWatchlistTv;
  final SaveTvWatchlist _saveWatchlistTv;

  TelevisionWatchListBloc(this._getWatchlistTv, this._getWatchlistStatusTv,
      this._removeWatchlistTv, this._saveWatchlistTv)
      : super(TelevisionWatchListInitial()) {
    on<OnFetchTelevisionWatchList>(_onFetchTvWatchList);
    on<TelevisionWatchListStatus>(_onTvWatchListStatus);
    on<TelevisionWatchListAdd>(_onTvWatchListAdd);
    on<TelevisionWatchListRemove>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchTvWatchList(OnFetchTelevisionWatchList event,
      Emitter<TelevisionWatchListState> emit) async {
    emit(TelevisionWatchListLoading());
    final result = await _getWatchlistTv.execute();
    result.fold((failure) {
      emit(TelevisionWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TelevisionWatchListEmpty())
          : emit(TelevisionWatchListHasData(success));
    });
  }

  FutureOr<void> _onTvWatchListStatus(TelevisionWatchListStatus event,
      Emitter<TelevisionWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchlistStatusTv.execute(id);
    emit(TelevisionWatchListIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(TelevisionWatchListAdd event,
      Emitter<TelevisionWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _saveWatchlistTv.execute(tv);
    result.fold((failure) {
      emit(TelevisionWatchListError(failure.message));
    }, (success) {
      emit(TelevisionWatchListMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(TelevisionWatchListRemove event,
      Emitter<TelevisionWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _removeWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(TelevisionWatchListError(failure.message));
    }, (success) {
      emit(TelevisionWatchListMessage(success));
    });
  }
}
