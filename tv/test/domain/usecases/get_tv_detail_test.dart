import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailTv usecase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetDetailTv(mockTvRepository);
  });

  const tId = 1;
  test('should get movie detail from the repository', () async {
    ///arrange
    when(mockTvRepository.getDetailTv(tId))
        .thenAnswer((_) async => Right(testTvDetail));

    ///act
    final result = await usecase.execute(tId);

    ///assert
    expect(result, Right(testTvDetail));
  });
}
