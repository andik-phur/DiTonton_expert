// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../widget/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    Future.microtask(() =>
        BlocProvider.of<MoviesPopularBloc>(context, listen: false)
            .add(OnMoviesPopular()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
            builder: (context, state) {
          if (state is MoviesPopularLoading) {
            return const CircularProgressIndicator();
          } else if (state is MoviesPopularHasData) {
            final data = state.result;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return MovieCard(movie);
                });
          } else {
            return Center(
              key: const Key("error_message"),
              child: Text((state as MoviesPopularError).message),
            );
          }
        }),
      ),
    );
  }
}
