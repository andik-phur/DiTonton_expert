// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

part 'popular_movies_event.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<OnMoviePopular>(_onMoviePopular);
  }

  FutureOr<void> _onMoviePopular(
      OnMoviePopular event, Emitter<MoviePopularState> emit) async {
    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(MoviePopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviePopularEmpty())
          : emit(MoviePopularHasData(success));
    });
  }
}
