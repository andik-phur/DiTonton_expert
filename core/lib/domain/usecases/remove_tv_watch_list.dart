// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class RemoveTvWatchlist {
  final TvRepository repository;
  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.removeTvWatchlist(tvDetail);
  }
}
