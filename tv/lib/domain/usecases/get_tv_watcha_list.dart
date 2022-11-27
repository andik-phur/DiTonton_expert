// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvWatchlist {
  final TvRepository _repository;
  GetTvWatchlist(this._repository);

  Future<Either<Failure, List<Television>>> execute() {
    return _repository.getTvWatchlist();
  }
}
