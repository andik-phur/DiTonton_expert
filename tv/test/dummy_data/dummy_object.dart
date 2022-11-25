import 'package:core/data/models/tv_model/tv_model.dart';
import 'package:core/data/models/tv_model/tv_respone.dart';
import 'package:core/data/models/tv_model/tv_table.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testTv = Television(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "backdropPath",
  genres: const [Genre(id: 1, name: "Action")],
  id: 1,
  originalName: "original_name",
  popularity: 1.0,
  overview: "overview",
  posterPath: "posterPath",
  firstAirDate: "releaseDate",
  name: "name",
  voteAverage: 1,
  voteCount: 1,
  originalLanguage: "en",
);

final testWatchlistTv = Television.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvTable = TvTables(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testTvfromCache = Television.watchlist(
  id: 11250,
  name: "Pasión de gavilanes",
  posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
  overview:
      "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
);
final testTVShowModel = ModelTv(
  backdropPath: "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
  genreIds: const [10767],
  id: 1991,
  name: "Rachael Ray",
  originCountry: const ["US"],
  originalLanguage: "en",
  originalName: "Rachael Ray",
  overview:
      "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.",
  popularity: 1765.863,
  posterPath: "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
  voteAverage: 5.8,
  voteCount: 29,
);

final testTVShowModelList = <ModelTv>[testTVShowModel];

final testTVShow = testTVShowModel.toEntity();

final testTVShowList = <Television>[testTVShow];

final testTVShowResponse = ResponseTv(tvList: testTVShowModelList);

final testTVShowDetailResponse = ModelTv(
  backdropPath: '',
  id: 2,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  voteAverage: 3,
  voteCount: 3,
  genreIds: const [],
  originCountry: const [],
);

final testTVShowDetail = testTVShowDetailResponse.toEntity();
