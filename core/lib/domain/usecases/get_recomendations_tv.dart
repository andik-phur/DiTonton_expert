// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);
  Future<Either<Failure, List<Television>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
