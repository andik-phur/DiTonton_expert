// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../datasources/tv_datasource/tv_local_data_source..dart';
import '../datasources/tv_datasource/tv_remote_data_source.dart';
import '../models/tv_model/tv_table.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource tvremoteDataSource;

  final TvLocalDataSource tvLocalDataSource;
  TvRepositoryImpl({
    required this.tvremoteDataSource,
    required this.tvLocalDataSource,
  });
  @override
  Future<Either<Failure, List<Television>>> getTopRatedtv() async {
    try {
      final result = await tvremoteDataSource.getTvTopRated();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    try {
      final result = await tvremoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<Television>>> getOnTheAirTv() async {
    try {
      final result = await tvremoteDataSource.getTvOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Television>>> getPopularTv() async {
    try {
      final result = await tvremoteDataSource.getTvPopular();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Television>>> getTvWatchlist() async {
    final result = await tvLocalDataSource.getWatchlistTv();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToTvWatchlist(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .removeWatchlistTv(TvTables.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .insertWatchlistTv(TvTables.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Television>>> Tvsearch(String query) async {
    try {
      final result = await tvremoteDataSource.searchTv(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Television>>> getTvRecommendations(int id) async {
    try {
      final result = await tvremoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerFailure {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }
}
