// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/presentation/widgets/scrolable_sheet.dart';
import 'package:core/styles/colors.dart';
import 'package:core/domain/entities/genre.dart';

import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/page_detail_tv';
  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnTvDetail(widget.id));
      context.read<TvRecommendationBloc>().add(OnTvRecommendation(widget.id));
      context.read<TvWatchListBloc>().add(TvWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTvShowAddedToWatchlist = context.select<TvWatchListBloc, bool>(
        (bloc) => (bloc.state is TvWatchListIsAdded)
            ? (bloc.state as TvWatchListIsAdded).isAdded
            : false);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {
              final tv = state.result;
              return ContentDetails(
                  tvDetail: tv, isAddedWatchlistTv: isTvShowAddedToWatchlist);
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}

class ContentDetails extends StatefulWidget {
  final TvDetail tvDetail;
  bool isAddedWatchlistTv;

  ContentDetails(
      {super.key, required this.tvDetail, required this.isAddedWatchlistTv});

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
        background: "$BASE_IMAGE_URL${widget.tvDetail.posterPath}",
        scrollableContents: [
          Text(
            widget.tvDetail.name,
            style: kHeading5,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!widget.isAddedWatchlistTv) {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListAdd(widget.tvDetail));
              } else {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListRemove(widget.tvDetail));
              }

              final state = BlocProvider.of<TvWatchListBloc>(context).state;
              String message = "";

              if (state is TvWatchListIsAdded) {
                final isAdded = state.isAdded;
                message = isAdded == false ? notifAdd : notifRemove;
              } else {
                message = !widget.isAddedWatchlistTv ? notifAdd : notifRemove;
              }

              if (message == notifAdd || message == notifRemove) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(message),
                      );
                    });
              }

              setState(() {
                widget.isAddedWatchlistTv = !widget.isAddedWatchlistTv;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isAddedWatchlistTv
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add),
                const SizedBox(width: 6.0),
                const Text('Watchlist'),
                const SizedBox(width: 4.0),
              ],
            ),
          ),
          Text(_showGenres(widget.tvDetail.genres)),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.tvDetail.voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kMikadoYellow,
                ),
                itemSize: 24,
              ),
              Text("${widget.tvDetail.voteAverage}")
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Overview",
            style: kHeading6,
          ),
          Text(widget.tvDetail.overview.isNotEmpty
              ? widget.tvDetail.overview
              : "-"),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Recommendation",
            style: kHeading6,
          ),
          BlocBuilder<TvRecommendationBloc, TvRecommendationState>(
            builder: (context, state) {
              if (state is TvRecommendationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvRecommendationHasData) {
                final tvShowRecommendations = state.result;

                return Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tvShowRecoms = tvShowRecommendations[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              TvDetailPage.routeName,
                              arguments: tvShowRecoms.id,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '$BASE_IMAGE_URL${tvShowRecoms.posterPath}',
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: tvShowRecommendations.length,
                  ),
                );
              } else {
                return const Text('No recommendations found');
              }
            },
          )
        ]);
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
