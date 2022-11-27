// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widget/movie_card_list.dart';
import '../bloc/top_rated/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top_rated_movies_page';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<MoviesTopRatedBloc>(context, listen: false)
            .add(OnMoviesTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
          key: const Key('top_rated_movies'),
          builder: (context, state) {
            if (state is MoviesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesTopRatedHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return MovieCard(movie);
                },
                itemCount: movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as MoviesTopRatedError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
