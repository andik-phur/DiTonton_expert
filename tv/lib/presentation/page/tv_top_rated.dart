// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';

class TvTopRatedPage extends StatefulWidget {
  static const routeName = '/top_rated_tv_page';

  const TvTopRatedPage({Key? key}) : super(key: key);

  @override
  _TvTopRatedPageState createState() => _TvTopRatedPageState();
}

class _TvTopRatedPageState extends State<TvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TelevisionTopRatedBloc>(context, listen: false)
            .add(OnTelevisionTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TelevisionTopRatedBloc, TelevisionTopRatedState>(
          key: const Key('top_rated_movies'),
          builder: (context, state) {
            if (state is TelevisionTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TelevisionTopRatedHasData) {
              // ignore: non_constant_identifier_names
              final Tvs = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = Tvs[index];

                  return CardTvList(tv);
                },
                itemCount: Tvs.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TelevisionTopRatedError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
