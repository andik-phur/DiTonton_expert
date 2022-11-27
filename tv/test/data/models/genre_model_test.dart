// ignore_for_file: prefer_const_declarations

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/domain/entities/genre.dart';

void main() {
  final genreModel = const GenresModel(id: 1, name: 'name');
  final genre = const Genre(id: 1, name: 'name');

  test('should be a subclass of genre entity', () async {
    final result = genreModel.toEntity();
    expect(result, genre);
  });
}
