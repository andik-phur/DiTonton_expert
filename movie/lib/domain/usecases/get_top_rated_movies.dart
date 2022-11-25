// ignore_for_file: depend_on_referenced_packages

import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/movie.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
