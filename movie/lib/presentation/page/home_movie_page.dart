// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/page/Now_playing_page.dart';
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
import 'package:google_nav_bar/google_nav_bar.dart';

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
      context.read<MoviesNowPlayingBloc>().add(OnMoviesNowPLayingCalled());
      context.read<MoviesTopRatedBloc>().add(OnMoviesTopRated());
      context.read<MoviesPopularBloc>().add(OnMoviesPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            gap: 10,
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.movie,
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage())),
                },
              ),
              GButton(
                icon: Icons.tv,
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TvPage())),
                },
              ),
              GButton(
                icon: Icons.help,
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage())),
                },
                text: 'About',
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('DiTonton'),
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
              _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () {
                    Navigator.pushNamed(context, NowPlayingPage.routeName);
                  }),
              BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
                  builder: (context, state) {
                if (state is MoviesNowPlayingLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MoviesNowPlayingHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MoviesNowPlayingError) {
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
              BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
                  builder: (context, state) {
                if (state is MoviesPopularLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MoviesPopularHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MoviesPopularError) {
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
              BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
                  builder: (context, state) {
                if (state is MoviesTopRatedLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MoviesTopRatedHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MoviesTopRatedError) {
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
