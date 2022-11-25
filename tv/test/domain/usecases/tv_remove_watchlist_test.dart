import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    ///arrange
    when(mockTvRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));

    ///act
    final result = await usecase.execute(testTvDetail);

    ///assert
    verify(mockTvRepository.removeTvWatchlist(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
