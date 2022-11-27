import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import '../../tv_test/dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingTv mockGetTvOnTheAir;
  late TelevisionOnTheAirBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockGetNowPlayingTv();
    tvOnTheAirBloc = TelevisionOnTheAirBloc(mockGetTvOnTheAir);
  });

  test('the initial state should be empty', () {
    expect(tvOnTheAirBloc.state, TelevisionOnTheAirEmpty());
  });

  blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionOnTheAir()),
    expect: () => [
      TelevisionOnTheAirLoading(),
      TelevisionOnTheAirHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
      return OnTelevisionOnTheAir().props;
    },
  );

  blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionOnTheAir()),
    expect: () => [
      TelevisionOnTheAirLoading(),
      TelevisionOnTheAirError('Server Failure'),
    ],
    verify: (bloc) => TelevisionOnTheAirLoading(),
  );

  blocTest<TelevisionOnTheAirBloc, TelevisionOnTheAirState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => const Right([]));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionOnTheAir()),
    expect: () => [
      TelevisionOnTheAirLoading(),
      TelevisionOnTheAirEmpty(),
    ],
  );
}
