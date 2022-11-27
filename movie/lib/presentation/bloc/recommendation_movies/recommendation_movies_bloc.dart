// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movies_state.dart';

part 'recommendation_movies_event.dart';

class MoviesRecommendationBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MoviesRecommendationBloc(this._getMovieRecommendations)
      : super(MoviesRecommendationEmpty()) {
    on<OnMoviesRecommendation>(_onMovieRecommendation);
  }

  FutureOr<void> _onMovieRecommendation(OnMoviesRecommendation event,
      Emitter<MoviesRecommendationState> emit) async {
    final id = event.id;
    emit(MoviesRecommendationLoading());

    final result = await _getMovieRecommendations.execute(id);
    result.fold((failure) {
      emit(MoviesRecommendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviesRecommendationEmpty())
          : emit(MoviesRecommendationHasData(success));
    });
  }
}
