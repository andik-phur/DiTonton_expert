// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
// ignore: depend_on_referenced_packages
import 'package:core/core.dart';

class DetailTvModelResponse extends Equatable {
  const DetailTvModelResponse(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.originalName,
      required this.name,
      required this.originalLanguage,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  final String? backdropPath;
  final String firstAirDate;
  final List<GenresModel> genres;
  final int id;
  final String originalName;
  final String name;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int? voteCount;

  factory DetailTvModelResponse.fromJson(Map<String, dynamic> json) =>
      DetailTvModelResponse(
          backdropPath: json["backdrop_path"],
          genres: List<GenresModel>.from(
              json["genres"].map((x) => GenresModel.fromJson(x))),
          id: json["id"],
          overview: json["overview"],
          popularity: json["popularity"].toDouble(),
          voteAverage: json["vote_average"].toDouble(),
          voteCount: json["vote_count"],
          firstAirDate: json["first_air_date"],
          name: json["name"],
          originalLanguage: json["original_language"],
          originalName: json["original_name"],
          posterPath: json["poster_path"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date": firstAirDate,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
        "poster_path": posterPath,
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        overview: overview,
        popularity: popularity,
        voteAverage: voteAverage,
        voteCount: voteCount,
        posterPath: posterPath,
        originalName: originalName,
        originalLanguage: originalLanguage,
        name: name,
        firstAirDate: firstAirDate);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        overview,
        popularity,
        voteAverage,
        voteCount,
        firstAirDate,
        name,
        originalLanguage,
        posterPath,
        originalName,
      ];
}
