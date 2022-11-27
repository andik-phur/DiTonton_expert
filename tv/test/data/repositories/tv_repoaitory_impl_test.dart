// ignore_for_file: prefer_const_declarations

import 'package:core/data/model/genre_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/model/tv_model/tv_detail_model.dart';
import 'package:tv/data/model/tv_model/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/repositories/tv_repositories_impl.dart';
import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/exception.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      tvremoteDataSource: mockTvRemoteDataSource,
      tvLocalDataSource: mockTvLocalDataSource,
    );
  });

  final tvModel = ModelTv(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: const [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: const ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765);

  final tv = Television(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: const [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: const ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765);

  final tvModelList = <ModelTv>[tvModel];
  final tvList = <Television>[tv];

  group('Top Rated Tv ', () {
    test('should return tv list when call to data source is success', () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvTopRated())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getTopRatedtv();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvTopRated()).thenThrow(ServerException());

      ///act
      final result = await repository.getTopRatedtv();

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv list when call to data source is success', () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvPopular())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getPopularTv();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvPopular()).thenThrow(ServerException());

      ///act
      final result = await repository.getPopularTv();

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('now playing Tv Series', () {
    test('should return tv list when call to data source is success', () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvOnTheAir())
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.getOnTheAirTv();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTvRemoteDataSource.getTvOnTheAir()).thenThrow(ServerException());

      ///act
      final result = await repository.getOnTheAirTv();

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'pasion';

    test('should return tv list when call to data source is success', () async {
      ///arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tvModelList);

      ///act
      final result = await repository.Tvsearch(tQuery);

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      ///arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());

      ///act
      final result = await repository.Tvsearch(tQuery);

      ///assert
      expect(result, const Left(ServerFailure('')));
    });
  });

  group('Save watchlist Tv ', () {
    test('should return success message when saving successful', () async {
      ///arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => "Added to watchlist tv");

      ///act
      final result = await repository.saveTvWatchlist(testTvDetail);

      ///assert
      expect(result, const Right('Added to watchlist tv'));
    });

    test('should return database failure when saving unsuccessful', () async {
      ///arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist tv'));

      ///act
      final result = await repository.saveTvWatchlist(testTvDetail);

      ///assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist tv')));
    });
  });

  group('Remove watchlist Tv ', () {
    test('should return success message when remove successful', () async {
      ///arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => "Removed from watchlist tv");

      ///act
      final result = await repository.removeTvWatchlist(testTvDetail);

      ///assert
      expect(result, const Right('Removed from watchlist tv'));
    });

    test('should return database failure when saving unsuccessful', () async {
      ///arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      ///act
      final result = await repository.removeTvWatchlist(testTvDetail);

      ///assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
  group('Remove watchlist status Tv ', () {
    test('should return watch status weather data is found', () async {
      ///arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

      ///act
      final result = await repository.isAddedToTvWatchlist(tId);

      ///assert
      expect(result, false);
    });
  });
  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToTvWatchlist(tId);
      // assert
      expect(result, false);
    });
  });
  group('Get watchlist Tv ', () {
    test('should return list of tv', () async {
      ///arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);

      ///act
      final result = await repository.getTvWatchlist();

      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
  group('Get TV Detail', () {
    final tId = 121;
    final tTVResponse = const DetailTvModelResponse(
      backdropPath: 'backdropPath',
      genres: [GenresModel(id: 1, name: 'Action')],
      id: 1,
      originalLanguage: 'en',
      originalName: 'original_name',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'releaseDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1,
    );
    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getDetailTv(tId))
          .thenAnswer((_) async => tTVResponse);
      // act
      final result = await repository.getDetailTv(tId);
      // assert
      verify(mockTvRemoteDataSource.getDetailTv(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getDetailTv(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetailTv(tId);
      // assert
      verify(mockTvRemoteDataSource.getDetailTv(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
