// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/page/popular_movies_page.dart';
import 'package:movie/presentation/page/top_rated_movies_page.dart';
import '../../domain/entities/movie.dart';
import '../bloc/now_playing/now_playing_movies_bloc.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../bloc/top_rated/top_rated_movies_bloc.dart';
import 'movie_detail_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/page/tv_home_page.dart';
import 'package:about/about_page.dart';
import 'package:core/presentation/widgets/tab_pager.dart';
import 'package:core/utils/constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/movie_home';

  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(OnMovieNowPLayingCalled());
      context.read<MovieTopRatedBloc>().add(OnMovieTopRated());
      context.read<MoviePopularBloc>().add(OnMoviePopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Nonton Kuy'),
                accountEmail: Text('')),
            ListTile(
              leading: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_outlined),
              title: const Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, TvPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, TabPager.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('DiTonton'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MovieNowPlayingHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MovieNowPlayingError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, PopularMoviesPage.routeName);
                  }),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                if (state is MoviePopularLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MoviePopularHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MoviePopularError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName);
                  }),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                if (state is MovieTopRatedLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MovieTopRatedHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MovieTopRatedError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [Text('See more'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                debugPrint('${movie.id}');
                Navigator.pushNamed(context, MovieDetailPage.routeName,
                    arguments: movie.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
