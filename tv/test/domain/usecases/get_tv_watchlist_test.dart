import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_watcha_list.dart';
import '../../tv_test/dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvWatchlist(mockTvRepository);
  });

  test('should get list of movies from the repository', () async {
    ///arrange
    when(mockTvRepository.getTvWatchlist())
        .thenAnswer((_) async => Right(testTvList));

    ///act
    final result = await usecase.execute();

    ///assert
    expect(result, Right(testTvList));
  });
}
