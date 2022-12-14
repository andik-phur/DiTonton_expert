// ignore_for_file: depend_on_referenced_packages

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tv_watchlist/tv_watchlist_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist_tv_page';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<TelevisionWatchListBloc>()
        .add(OnFetchTelevisionWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TelevisionWatchListBloc>().add(OnFetchTelevisionWatchList());
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<TelevisionWatchListBloc, TelevisionWatchListState>(
          builder: (context, state) {
        if (state is TelevisionWatchListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TelevisionWatchListHasData) {
          final data = state.result;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final tv = data[index];
              return CardTvList(tv);
            },
          );
        } else if (state is TelevisionWatchListEmpty) {
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
