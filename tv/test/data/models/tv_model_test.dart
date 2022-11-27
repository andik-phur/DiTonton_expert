import 'package:core/data/models/tv_model/tv_model.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvModel = ModelTv(
      backdropPath: "backdropPath",
      genreIds: const [18],
      id: 11250,
      name: "Name",
      originCountry: const ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1);
  final tv = Television(
      backdropPath: "backdropPath",
      genreIds: const [18],
      id: 11250,
      name: "Name",
      originCountry: const ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of tv entity', () async {
    final result = tvModel.toEntity();
    expect(result, tv);
  });
}
