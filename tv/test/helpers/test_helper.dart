// ignore_for_file: depend_on_referenced_package, depend_on_referenced_packages
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';
import 'package:tv/datasources/db/tv_db/tv_database_helper.dart';
import 'package:tv/datasources/tv_datasource/tv_local_data_source.dart';
import 'package:tv/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/get_detail_tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_recomendations_tv.dart';
import 'package:tv/domain/usecases/get_top_rate_tv.dart';
import 'package:tv/domain/usecases/get_tv_watcha_list.dart';
import 'package:tv/domain/usecases/get_watch_list_status_tv.dart';
import 'package:tv/domain/usecases/remove_tv_watch_list.dart';
import 'package:tv/domain/usecases/save_tv_watch_list.dart';

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
