// ignore_for_file: depend_on_referenced_packages

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';

class TvNowPlayingPage extends StatefulWidget {
  static const routeName = '/Now_playing_tv_page';

  const TvNowPlayingPage({Key? key}) : super(key: key);

  @override
  State<TvNowPlayingPage> createState() => _TvNowPlayingPageState();
}

class _TvNowPlayingPageState extends State<TvNowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TelevisionOnTheAirBloc>().add(OnTelevisionOnTheAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
            builder: (context, state) {
          if (state is TelevisionOnTheAirLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TelevisionOnTheAirHasData) {
            final popular = state.result;
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final tvPopular = popular[index];
                return CardTvList(tvPopular);
              },
            );
          } else {
            return Center(
              key: const Key("error_message"),
              child: Text((state as TelevisionOnTheAirError).message),
            );
          }
        }),
      ),
    );
  }
}
