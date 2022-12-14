// ignore_for_file: depend_on_referenced_packages

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular_tv_page';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TelevisionPopularBloc>().add(OnTelevisionPopular()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TelevisionPopularBloc, TelevisionPopularState>(
            builder: (context, state) {
          if (state is TelevisionPopularLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TelevisionPopularHasData) {
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
              child: Text((state as TelevisionPopularError).message),
            );
          }
        }),
      ),
    );
  }
}
