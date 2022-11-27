// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:tv/data/model/tv_model/tv_detail_model.dart';
import 'package:tv/data/model/tv_model/tv_respone.dart';
import 'package:tv/datasources/tv_datasource/tv_remote_data_source.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });
  group('Get Now Playing Tv Series', () {
    final tvList = ResponseTv.fromJson(
            json.decode(readJson('tv_test/dummy_data/now_playing_tv.json')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('tv_test/dummy_data/now_playing_tv.json'), 200));

      ///act
      final result = await dataSource.getTvOnTheAir();

      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      ///act
      final call = dataSource.getTvOnTheAir();

      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('Get Top Rated Tv ', () {
    final tvList = ResponseTv.fromJson(
            json.decode(readJson('tv_test/dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('tv_test/dummy_data/tv_top_rated.json'), 200));

      ///act
      final result = await dataSource.getTvTopRated();

      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      ///act
      final call = dataSource.getTvTopRated();

      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('search tv', () {
    final tSearchResult = ResponseTv.fromJson(
            json.decode(readJson('tv_test/dummy_data/search_tv.json')))
        .tvList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      ///arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('tv_test/dummy_data/search_tv.json'), 200));

      ///act
      final result = await dataSource.searchTv(tQuery);

      ///assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      ///arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      ///act
      final call = dataSource.searchTv(tQuery);

      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 1;
    final tvDetail = DetailTvModelResponse.fromJson(
        json.decode(readJson('tv_test/dummy_data/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('tv_test/dummy_data/tv_detail.json'), 200));

      ///act
      final result = await dataSource.getDetailTv(tId);

      ///assert
      expect(result, equals(tvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      ///act
      final call = dataSource.getDetailTv(tId);

      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv Series', () {
    final tvList = ResponseTv.fromJson(
            json.decode(readJson('tv_test/dummy_data/tv_popular.json')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('tv_test/dummy_data/tv_popular.json'), 200));

      ///act
      final result = await dataSource.getTvPopular();

      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      ///act
      final call = dataSource.getTvPopular();

      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
