import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'injection.dart' as di;
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/page/tv_detail_page.dart';
import 'package:tv/presentation/page/tv_top_rated.dart';
import 'package:tv/presentation/page/tv_popular_page.dart';
import 'package:tv/presentation/page/watchlist_tv_page.dart';
import 'package:tv/presentation/page/tv_home_page.dart';
import 'package:search/presentation/bloc/movie_bloc_search/search_movie_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:about/about_page.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/presentation/page/home_movie_page.dart';
import 'package:movie/presentation/page/movie_detail_page.dart';
import 'package:movie/presentation/page/popular_movies_page.dart';
import 'package:movie/presentation/page/top_rated_movies_page.dart';
import 'package:movie/presentation/page/watchlist_movies_page.dart';
import 'package:core/presentation/widgets/tab_pager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBlocTv>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TelevisionTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TelevisionWatchListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesWatchListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TelevisionPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TelevisionOnTheAirBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
            colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow)),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id), settings: settings);
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TvTopRatedPage.routeName:
              return MaterialPageRoute(builder: (_) => TvTopRatedPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case PopularTvPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case SearchTvPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case TvPage.routeName:
              return MaterialPageRoute(builder: (_) => TvPage());
            case TabPager.routeName:
              return MaterialPageRoute(builder: (_) => TabPager());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found!'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
