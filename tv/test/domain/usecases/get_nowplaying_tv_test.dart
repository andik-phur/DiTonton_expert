import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTv usecase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingTv(mockTvRepository);
  });

  final tv = <Television>[];
  group('Get On The Air TV Series', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      ///arrange
      when(mockTvRepository.getOnTheAirTv()).thenAnswer((_) async => Right(tv));

      ///act
      final result = await usecase.execute();

      ///assert
      expect(result, Right(tv));
    });
  });
}
