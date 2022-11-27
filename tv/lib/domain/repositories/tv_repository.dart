// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import '../entities/tv_detail.dart';
import 'package:core/utils/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, TvDetail>> getDetailTv(int id);
  Future<Either<Failure, List<Television>>> getOnTheAirTv();
  Future<Either<Failure, List<Television>>> getTopRatedtv();
  Future<Either<Failure, List<Television>>> getPopularTv();

  Future<Either<Failure, List<Television>>> Tvsearch(String query);

  Future<Either<Failure, List<Television>>> getTvRecommendations(int id);

  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tvDetail);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tvDetail);
  Future<bool> isAddedToTvWatchlist(int id);
  Future<Either<Failure, List<Television>>> getTvWatchlist();
}
