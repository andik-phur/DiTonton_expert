import 'package:get_it/get_it.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:search/search.dart';
import 'package:search/presentation/bloc/movie_bloc_search/search_movie_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/data/datasource/movie_local_data_source.dart';
import 'package:movie/data/datasource/db/database_helper.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tv/tv.dart';
import 'package:core/utils/ssl_pinning.dart';

final locator = GetIt.instance;

void init() {
  ///bloc movie
  locator.registerFactory(() => MoviesTopRatedBloc(locator()));
  locator.registerFactory(() => MoviesPopularBloc(locator()));

  locator.registerFactory(() => MoviesNowPlayingBloc(locator()));
  locator.registerFactory(() => MoviesDetailBloc(locator()));
  locator.registerFactory(() => MoviesRecommendationBloc(locator()));

  ///tv bloc
  locator.registerFactory(() => TelevisionOnTheAirBloc(locator()));
  locator.registerFactory(() => DetailTvBloc(
        locator(),
      ));
  locator.registerFactory(() => TelevisionPopularBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(
        locator(),
      ));
  locator.registerFactory(() => TelevisionTopRatedBloc(
        locator(),
      ));

  ///search bloc
  locator.registerFactory(() => SearchBloc(locator()));

  ///watchlist bloc
  locator.registerFactory(() => MoviesWatchListBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => SearchBlocTv(locator()));

  locator.registerFactory(() => TelevisionWatchListBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  ///use case movie
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));

  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));

  ///
  locator.registerLazySingleton(() => TvSearch(locator()));

  locator.registerLazySingleton(() => SearchMovies(locator()));

  ///use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));

  locator.registerLazySingleton(() => GetTopRatedTv(locator()));

  ///watchlist movie
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  ///watchlist tv
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));

  locator.registerLazySingleton(() => GetTvWatchlist(locator()));

  ///repository movie
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
        tvremoteDataSource: locator(),
        tvLocalDataSource: locator(),
      ));
  // data sources

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelperTv: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  locator.registerLazySingleton(() => SslPinning.client);
}
