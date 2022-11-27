// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rate_tv.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TelevisionTopRatedBloc
    extends Bloc<TelevisionTopRatedEvent, TelevisionTopRatedState> {
  final GetTopRatedTv _getTvTopRated;

  TelevisionTopRatedBloc(this._getTvTopRated)
      : super(TelevisionTopRatedEmpty()) {
    on<OnTelevisionTopRated>(_onTvTopRated);
  }

  FutureOr<void> _onTvTopRated(
      OnTelevisionTopRated event, Emitter<TelevisionTopRatedState> emit) async {
    emit(TelevisionTopRatedLoading());
    final result = await _getTvTopRated.execute();

    result.fold((failure) {
      emit(TelevisionTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TelevisionTopRatedEmpty())
          : emit(TelevisionTopRatedHasData(success));
    });
  }
}
