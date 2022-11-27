// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

part 'popular_movies_event.dart';

class MoviesPopularBloc extends Bloc<MoviesPopularEvent, MoviesPopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviesPopularBloc(this._getPopularMovies) : super(MoviesPopularEmpty()) {
    on<OnMoviesPopular>(_onMoviePopular);
  }

  FutureOr<void> _onMoviePopular(
      OnMoviesPopular event, Emitter<MoviesPopularState> emit) async {
    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(MoviesPopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviesPopularEmpty())
          : emit(MoviesPopularHasData(success));
    });
  }
}
