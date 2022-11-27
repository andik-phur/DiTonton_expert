// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:core/utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class GetDetailTv {
  final TvRepository repository;

  GetDetailTv(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getDetailTv(id);
  }
}
