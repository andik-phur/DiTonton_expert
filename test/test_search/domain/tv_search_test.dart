import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late TvSearch usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = TvSearch(mockTvRepository);
  });

  final tv = <Television>[];
  const tQuery = "Spiderman";
  test('should get list of movies from the repository', () async {
    ///arrange
    when(mockTvRepository.Tvsearch(tQuery)).thenAnswer((_) async => Right(tv));

    ///act
    final result = await usecase.execute(tQuery);

    ///assert
    expect(result, Right(tv));
  });
}
