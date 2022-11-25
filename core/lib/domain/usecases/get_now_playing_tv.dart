// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);
  Future<Either<Failure, List<Television>>> execute() {
    return repository.getOnTheAirTv();
  }
}
