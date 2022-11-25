// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_now_playing_event.dart';

part 'tv_now_playing_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetNowPlayingTv _getTvOnTheAir;

  TvOnTheAirBloc(this._getTvOnTheAir) : super(TvOnTheAirEmpty()) {
    on<OnTvOnTheAir>(_onTvOnTheAir);
  }

  FutureOr<void> _onTvOnTheAir(
      OnTvOnTheAir event, Emitter<TvOnTheAirState> emit) async {
    emit(TvOnTheAirLoading());
    final result = await _getTvOnTheAir.execute();

    result.fold((failure) {
      emit(TvOnTheAirError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvOnTheAirEmpty())
          : emit(TvOnTheAirHasData(success));
    });
  }
}
