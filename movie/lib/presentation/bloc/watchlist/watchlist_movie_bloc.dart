// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class MoviesWatchListBloc
    extends Bloc<MoviesWatchListEvent, MoviesWatchListState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  MoviesWatchListBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(MoviesWatchListInitial()) {
    on<OnFetchMoviesWatchList>(_onFetchMovieWatchList);
    on<MoviesWatchListStatus>(_onMovieWatchListStatus);
    on<MoviesWatchListAdd>(_onMovieWatchListAdd);
    on<MoviesWatchListRemove>(_onMovieWatchListRemove);
  }

  FutureOr<void> _onFetchMovieWatchList(
      OnFetchMoviesWatchList event, Emitter<MoviesWatchListState> emit) async {
    emit(MoviesWatchListLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(MoviesWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviesWatchListEmpty())
          : emit(MoviesWatchListHasData(success));
    });
  }

  FutureOr<void> _onMovieWatchListStatus(
      MoviesWatchListStatus event, Emitter<MoviesWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);
    emit(MoviesWatchListIsAdded(result));
  }

  FutureOr<void> _onMovieWatchListAdd(
      MoviesWatchListAdd event, Emitter<MoviesWatchListState> emit) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(MoviesWatchListError(failure.message));
    }, (success) {
      emit(MoviesWatchListMessage(success));
    });
  }

  FutureOr<void> _onMovieWatchListRemove(
      MoviesWatchListRemove event, Emitter<MoviesWatchListState> emit) async {
    final movie = event.movieDetail;
    final result = await _removeWatchlist.execute(movie);
    result.fold((failure) {
      emit(MoviesWatchListError(failure.message));
    }, (success) {
      emit(MoviesWatchListMessage(success));
    });
  }
}
