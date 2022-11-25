// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_detail_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetDetailTv _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailEmpty()) {
    on<OnTvDetail>(_onTvDetail);
  }

  FutureOr<void> _onTvDetail(
      OnTvDetail event, Emitter<TvDetailState> emit) async {
    final id = event.id;

    emit(TvDetailLoading());

    final result = await _getTvDetail.execute(id);

    result.fold((failure) {
      emit(TvDetailError(failure.message));
    }, (success) {
      emit(TvDetailHasData(success));
    });
  }
}
