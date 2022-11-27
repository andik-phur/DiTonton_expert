// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail _getMovieDetail;

  MoviesDetailBloc(this._getMovieDetail) : super(MoviesDetailEmpty()) {
    on<OnMoviesDetail>(_onMovieDetail);
  }

  FutureOr<void> _onMovieDetail(
      OnMoviesDetail event, Emitter<MoviesDetailState> emit) async {
    final id = event.id;

    emit(MoviesDetailLoading());
    final result = await _getMovieDetail.execute(id);

    result.fold((failure) {
      emit(MoviesDetailError(failure.message));
    }, (success) {
      emit(MoviesDetailHasData(success));
    });
  }
}
