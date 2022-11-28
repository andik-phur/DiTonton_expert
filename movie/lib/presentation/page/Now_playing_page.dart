// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import '../widget/movie_card_list.dart';

class NowPlayingPage extends StatefulWidget {
  static const routeName = '/nowPlaying';

  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  void initState() {
    Future.microtask(() =>
        BlocProvider.of<MoviesNowPlayingBloc>(context, listen: false)
            .add(OnMoviesNowPLayingCalled()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
            builder: (context, state) {
          if (state is MoviesNowPlayingLoading) {
            return const CircularProgressIndicator();
          } else if (state is MoviesNowPlayingHasData) {
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
              child: Text((state as MoviesNowPlayingError).message),
            );
          }
        }),
      ),
    );
  }
}
