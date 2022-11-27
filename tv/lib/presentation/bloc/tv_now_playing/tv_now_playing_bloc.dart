// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

part 'tv_now_playing_event.dart';

part 'tv_now_playing_state.dart';

class TelevisionOnTheAirBloc
    extends Bloc<TelevisionOnTheAirEvent, TelevisionOnTheAirState> {
  final GetNowPlayingTv _getTvOnTheAir;

  TelevisionOnTheAirBloc(this._getTvOnTheAir)
      : super(TelevisionOnTheAirEmpty()) {
    on<OnTelevisionOnTheAir>(_onTvOnTheAir);
  }

  FutureOr<void> _onTvOnTheAir(
      OnTelevisionOnTheAir event, Emitter<TelevisionOnTheAirState> emit) async {
    emit(TelevisionOnTheAirLoading());
    final result = await _getTvOnTheAir.execute();

    result.fold((failure) {
      emit(TelevisionOnTheAirError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TelevisionOnTheAirEmpty())
          : emit(TelevisionOnTheAirHasData(success));
    });
  }
}
