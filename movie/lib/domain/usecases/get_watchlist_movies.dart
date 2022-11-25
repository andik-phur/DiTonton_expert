// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
