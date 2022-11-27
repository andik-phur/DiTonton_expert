// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class MoviesTopRatedBloc
    extends Bloc<MoviesTopRatedEvent, MoviesTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MoviesTopRatedBloc(this._getTopRatedMovies) : super(MoviesTopRatedEmpty()) {
    on<OnMoviesTopRated>(_onMovieTopRated);
  }

  FutureOr<void> _onMovieTopRated(
      OnMoviesTopRated event, Emitter<MoviesTopRatedState> emit) async {
    emit(MoviesTopRatedLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(MoviesTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviesTopRatedEmpty())
          : emit(MoviesTopRatedHasData(success));
    });
  }
}
