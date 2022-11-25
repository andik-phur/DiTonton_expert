// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';

@GenerateMocks([
  TvLocalDataSource,
  DatabaseHelperTv,
  TvRepository,
  TvRemoteDataSource,
  GetDetailTv,
  GetPopularTv,
  GetNowPlayingTv,
  GetTopRatedTv,
  GetTvRecommendations,
  GetTvWatchlist,
  GetTvWatchlistStatus,
  RemoveTvWatchlist,
  SaveTvWatchlist,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
