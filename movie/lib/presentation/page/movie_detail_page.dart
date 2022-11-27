// ignore_for_file: library_private_types_in_public_api, must_be_immutable, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import '../../domain/entities/movie_detail.dart';
import 'package:core/utils/constants.dart';
import 'package:core/presentation/widgets/scrolable_sheet.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/domain/entities/genre.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviesDetailBloc>().add(OnMoviesDetail(widget.id));
      context
          .read<MoviesRecommendationBloc>()
          .add(OnMoviesRecommendation(widget.id));
      context.read<MoviesWatchListBloc>().add(MoviesWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddedToWatchList =
        context.select<MoviesWatchListBloc, bool>((bloc) {
      if (bloc.state is MoviesWatchListIsAdded) {
        return (bloc.state as MoviesWatchListIsAdded).isAdded;
      }
      return false;
    });
    return SafeArea(
      child: Scaffold(body: BlocBuilder<MoviesDetailBloc, MoviesDetailState>(
        builder: (context, state) {
          if (state is MoviesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviesDetailHasData) {
            final movie = state.result;
            return ContentDetails(
                movie: movie, isAddedWatchlist: isMovieAddedToWatchList);
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        },
      )),
    );
  }
}

class ContentDetails extends StatefulWidget {
  final MovieDetail movie;
  bool isAddedWatchlist;

  ContentDetails({
    Key? key,
    required this.movie,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      background: '$BASE_IMAGE_URL${widget.movie.posterPath}',
      scrollableContents: [
        Text(
          widget.movie.title,
          style: kHeading5,
        ),
        ElevatedButton(
            onPressed: () async {
              if (!widget.isAddedWatchlist) {
                context
                    .read<MoviesWatchListBloc>()
                    .add(MoviesWatchListAdd(widget.movie));
              } else {
                context
                    .read<MoviesWatchListBloc>()
                    .add(MoviesWatchListRemove(widget.movie));
              }
              final state = BlocProvider.of<MoviesWatchListBloc>(context).state;
              String message = "";

              if (state is MoviesWatchListIsAdded) {
                final isAdded = state.isAdded;
                message = isAdded == false ? notifAdd : notifRemove;
              } else {
                message = !widget.isAddedWatchlist ? notifAdd : notifRemove;
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
                widget.isAddedWatchlist = !widget.isAddedWatchlist;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isAddedWatchlist
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add),
                const SizedBox(
                  width: 6,
                ),
                const Text("Watchlist"),
                const SizedBox(
                  width: 6,
                ),
              ],
            )),
        Text(_showGenres(widget.movie.genres)),
        Text(_showDuration(widget.movie.runtime)),
        Row(
          children: [
            RatingBarIndicator(
              rating: widget.movie.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text("${widget.movie.voteAverage}")
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(widget.movie.overview.isNotEmpty ? widget.movie.overview : "-"),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Recommendations',
          style: kHeading6,
        ),
        BlocBuilder<MoviesRecommendationBloc, MoviesRecommendationState>(
            builder: (context, state) {
          if (state is MoviesRecommendationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviesRecommendationHasData) {
            final movieRecommendation = state.result;
            return Container(
              margin: const EdgeInsets.only(top: 8),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final recommendation = movieRecommendation[index];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, MovieDetailPage.routeName,
                            arguments: recommendation);
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl:
                              "$BASE_IMAGE_URL${recommendation.posterPath}",
                          placeholder: (context, url) => const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
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
                itemCount: movieRecommendation.length,
              ),
            );
          } else if (state is MoviesRecommendationEmpty) {
            return const Text("-");
          } else {
            return const Text("Failed");
          }
        }),
        const SizedBox(
          height: 16,
        )
      ],
    );
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
