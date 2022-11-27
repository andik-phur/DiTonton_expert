// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widget/movie_card_list.dart';
import 'package:core/utils/utils.dart';

import '../bloc/watchlist/watchlist_movie_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MoviesWatchListBloc>().add(OnFetchMoviesWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(() =>
        context.read<MoviesWatchListBloc>().add(OnFetchMoviesWatchList()));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<MoviesWatchListBloc, MoviesWatchListState>(
          builder: (context, state) {
        if (state is MoviesWatchListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesWatchListHasData) {
          final data = state.result;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final movie = data[index];
              return MovieCard(movie);
            },
          );
        } else if (state is MoviesWatchListEmpty) {
          return const Center(
            child: Text("Watchlist Empty"),
          );
        } else {
          return const Center(
            key: Key("error_message"),
            child: Text("Failed"),
          );
        }
      }),
    );
  }
}
