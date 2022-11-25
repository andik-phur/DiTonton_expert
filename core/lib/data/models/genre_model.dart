// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

import '../../domain/entities/genre.dart';

class GenresModel extends Equatable {
  const GenresModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Genre toEntity() {
    return Genre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
