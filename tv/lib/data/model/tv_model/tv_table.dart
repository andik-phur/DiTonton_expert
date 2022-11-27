// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class TvTables extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTables(
      {required this.id,
      required this.name,
      required this.posterPath,
      required this.overview});

  factory TvTables.fromEntity(TvDetail tvDetail) => TvTables(
      id: tvDetail.id,
      name: tvDetail.name,
      posterPath: tvDetail.posterPath,
      overview: tvDetail.overview);

  factory TvTables.fromMap(Map<String, dynamic> map) => TvTables(
        id: map["id"],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Television toEntity() => Television.watchlist(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
