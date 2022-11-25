// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

// ignore: depend_on_referenced_packages
import 'package:core/utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
