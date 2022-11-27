// ignore_for_file: file_names

import 'package:core/domain/usecases/get_recomendations_tv.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  const tId = 1;
  final tv = <Television>[];
  test('should get list of movie recommendations from the repository',
      () async {
    ///arrange
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tv));

    ///act
    final result = await usecase.execute(tId);

    ///assert
    expect(result, Right(tv));
  });
}
