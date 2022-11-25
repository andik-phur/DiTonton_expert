import 'dart:convert';
import 'package:core/data/models/tv_model/tv_model.dart';
import 'package:core/data/models/tv_model/tv_respone.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../json_reader.dart';

void main() {
  final ttvModel = ModelTv(
    backdropPath: "/path.jpg",
    genreIds: const [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
    originalName: '',
    originalLanguage: 'en',
    originCountry: const ["US"],
  );
  final ttvResponseModel = ResponseTv(tvList: <ModelTv>[ttvModel]);

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      ///arrange

      ///act
      final result = ttvResponseModel.toJson();

      ///assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1,
            "original_name": '',
            "original_language": 'en',
            "origin_country": ["US"],
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      ///arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('tv_test/dummy_data/now_playing_tv.json'));
      //act
      final result = ResponseTv.fromJson(jsonMap);

      ///assert
      expect(result, ttvResponseModel);
    });
  });
}
