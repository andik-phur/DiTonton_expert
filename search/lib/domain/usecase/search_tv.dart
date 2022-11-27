// ignore_for_file: depend_on_referenced_packages

import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class TvSearch {
  final TvRepository repository;
  TvSearch(this.repository);

  Future<Either<Failure, List<Television>>> execute(String query) {
    return repository.Tvsearch(query);
  }
}
