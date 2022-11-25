// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
