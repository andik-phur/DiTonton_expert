// ignore: depend_on_referenced_packages
// ignore_for_file: must_be_immutable

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class Television extends Equatable {
  Television({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Television.watchlist({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
