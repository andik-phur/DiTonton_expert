// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class MoviesNowPlayingBloc
    extends Bloc<MoviesNowPlayingEvent, MoviesNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MoviesNowPlayingBloc(
    this._getNowPlayingMovies,
  ) : super(MoviesNowPlayingEmpty()) {
    on<OnMoviesNowPLayingCalled>(_onMovieNowPlayingCalled);
  }

  FutureOr<void> _onMovieNowPlayingCalled(OnMoviesNowPLayingCalled event,
      Emitter<MoviesNowPlayingState> emit) async {
    emit(MoviesNowPlayingLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(MoviesNowPlayingError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviesNowPlayingEmpty())
          : emit(MoviesNowPlayingHasData(success));
    });
  }
}
