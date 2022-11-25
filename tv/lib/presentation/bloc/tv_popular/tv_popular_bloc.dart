// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv _getTvPopular;

  TvPopularBloc(this._getTvPopular) : super(TvPopularEmpty()) {
    on<OnTvPopular>(_onTvPopular);
  }

  FutureOr<void> _onTvPopular(
      OnTvPopular event, Emitter<TvPopularState> emit) async {
    emit(TvPopularLoading());
    final result = await _getTvPopular.execute();

    result.fold((failure) {
      emit(TvPopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvPopularEmpty())
          : emit(TvPopularHasData(success));
    });
  }
}
