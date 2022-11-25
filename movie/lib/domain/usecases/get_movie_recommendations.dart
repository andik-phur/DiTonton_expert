// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:core/utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
