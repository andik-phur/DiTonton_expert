// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<OnMovieTopRated>(_onMovieTopRated);
  }

  FutureOr<void> _onMovieTopRated(
      OnMovieTopRated event, Emitter<MovieTopRatedState> emit) async {
    emit(MovieTopRatedLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(MovieTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieTopRatedEmpty())
          : emit(MovieTopRatedHasData(success));
    });
  }
}
