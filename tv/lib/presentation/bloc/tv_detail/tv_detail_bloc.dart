// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_detail_tv.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetDetailTv _getTvDetail;

  DetailTvBloc(this._getTvDetail) : super(TelevisionDetailEmpty()) {
    on<OnTelevisionDetail>(_onTvDetail);
  }

  FutureOr<void> _onTvDetail(
      OnTelevisionDetail event, Emitter<DetailTvState> emit) async {
    final id = event.id;

    emit(TelevisionDetailLoading());

    final result = await _getTvDetail.execute(id);

    result.fold((failure) {
      emit(TelevisionDetailError(failure.message));
    }, (success) {
      emit(DetailTvHasData(success));
    });
  }
}
