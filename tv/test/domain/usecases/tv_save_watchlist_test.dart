import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_tv_watch_list.dart';
import '../../tv_test/dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveTvWatchlist(mockTvRepository);
  });
  test('should save tv to the repository', () async {
    ///arrange
    when(mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));

    ///act
    final result = await usecase.execute(testTvDetail);

    ///assert
    verify(mockTvRepository.saveTvWatchlist(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
