// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/widgets/tab_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/page/tv_detail_page.dart';
import 'package:tv/presentation/page/tv_top_rated.dart';
import 'package:tv/presentation/page/tv_popular_page.dart';
import 'package:search/presentation/pages/tv_search_page.dart';
import 'package:about/about_page.dart';
import 'package:movie/presentation/page/home_movie_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';

class TvPage extends StatefulWidget {
  static const routeName = '/tv_home';

  const TvPage({Key? key}) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnTheAirBloc>().add(OnTvOnTheAir());
      context.read<TvPopularBloc>().add(OnTvPopular());
      context.read<TvTopRatedBloc>().add(OnTvTopRated());
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
              onTap: () => {Navigator.pushNamed(context, HomePage.routeName)},
            ),
            ListTile(
              leading: const Icon(Icons.tv_outlined),
              title: const Text('TV'),
              onTap: () => {Navigator.pop(context)},
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
                Navigator.pushNamed(context, SearchTvPage.routeName);
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
                'Tv Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
                  builder: (context, state) {
                if (state is TvOnTheAirLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvOnTheAirHasData) {
                  return TvList(state.result);
                } else {
                  return const Text("Failed");
                }
              }),
              _buildSubHeading(
                  title: 'Tv Popular',
                  onTap: () {
                    Navigator.pushNamed(context, PopularTvPage.routeName);
                  }),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                  builder: (context, state) {
                if (state is TvPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvPopularHasData) {
                  return TvList(state.result);
                } else {
                  return const Text("Failed");
                }
              }),
              _buildSubHeading(
                  title: 'Tv Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TvTopRatedPage.routeName);
                  }),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                  builder: (context, state) {
                if (state is TvTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvTopRatedHasData) {
                  return TvList(state.result);
                } else {
                  return const Text("Failed");
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

class TvList extends StatelessWidget {
  final List<Television> tv;

  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tv.length,
        itemBuilder: (context, index) {
          final movieTv = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                debugPrint('${movieTv.id}');
                Navigator.pushNamed(context, TvDetailPage.routeName,
                    arguments: movieTv.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movieTv.posterPath}',
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
