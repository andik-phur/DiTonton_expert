// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);
  Future<Either<Failure, List<Television>>> execute() {
    return repository.getTopRatedtv();
  }
}
