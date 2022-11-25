import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvWatchlistStatus usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvWatchlistStatus(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    ///arrange
    when(mockTvRepository.isAddedToTvWatchlist(1))
        .thenAnswer((_) async => true);

    ///act
    final result = await usecase.execute(1);

    ///assert
    expect(result, true);
  });
}
