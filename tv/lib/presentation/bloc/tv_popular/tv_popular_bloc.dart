// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TelevisionPopularBloc
    extends Bloc<TelevisionPopularEvent, TelevisionPopularState> {
  final GetPopularTv _getTvPopular;

  TelevisionPopularBloc(this._getTvPopular) : super(TelevisionPopularEmpty()) {
    on<OnTelevisionPopular>(_onTvPopular);
  }

  FutureOr<void> _onTvPopular(
      OnTelevisionPopular event, Emitter<TelevisionPopularState> emit) async {
    emit(TelevisionPopularLoading());
    final result = await _getTvPopular.execute();

    result.fold((failure) {
      emit(TelevisionPopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TelevisionPopularEmpty())
          : emit(TelevisionPopularHasData(success));
    });
  }
}
