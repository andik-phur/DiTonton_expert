// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
