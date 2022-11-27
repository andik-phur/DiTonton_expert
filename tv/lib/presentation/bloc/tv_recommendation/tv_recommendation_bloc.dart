// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_recomendations_tv.dart';

part 'tv_recommendation_event.dart';

part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TelevisionRecommendationEvent, TelevisionRecommendationState> {
  final GetTvRecommendations _getRecommendationsTv;

  TvRecommendationBloc(this._getRecommendationsTv)
      : super(TelevisionRecommendationEmpty()) {
    on<OnTelevisionRecommendation>(_onTvRecommendation);
  }

  FutureOr<void> _onTvRecommendation(OnTelevisionRecommendation event,
      Emitter<TelevisionRecommendationState> emit) async {
    final id = event.id;

    emit(TelevisionRecommendationLoading());
    final result = await _getRecommendationsTv.execute(id);

    result.fold((failure) {
      emit(TelevisionRecommendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TelevisionRecommendationEmpty())
          : emit(TelevisionRecommendationHasData(success));
    });
  }
}
