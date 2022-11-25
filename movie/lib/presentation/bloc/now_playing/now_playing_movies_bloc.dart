// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(
    this._getNowPlayingMovies,
  ) : super(MovieNowPlayingEmpty()) {
    on<OnMovieNowPLayingCalled>(_onMovieNowPlayingCalled);
  }

  FutureOr<void> _onMovieNowPlayingCalled(
      OnMovieNowPLayingCalled event, Emitter<MovieNowPlayingState> emit) async {
    emit(MovieNowPlayingLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(MovieNowPlayingError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieNowPlayingEmpty())
          : emit(MovieNowPlayingHasData(success));
    });
  }
}
