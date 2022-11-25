// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rate_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv _getTvTopRated;

  TvTopRatedBloc(this._getTvTopRated) : super(TvTopRatedEmpty()) {
    on<OnTvTopRated>(_onTvTopRated);
  }

  FutureOr<void> _onTvTopRated(
      OnTvTopRated event, Emitter<TvTopRatedState> emit) async {
    emit(TvTopRatedLoading());
    final result = await _getTvTopRated.execute();

    result.fold((failure) {
      emit(TvTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvTopRatedEmpty())
          : emit(TvTopRatedHasData(success));
    });
  }
}
