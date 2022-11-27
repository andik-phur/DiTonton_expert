import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';

import '../../tv_test/dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTv mockGetTvTopRated;
  late TelevisionTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTopRatedTv();
    tvTopRatedBloc = TelevisionTopRatedBloc(mockGetTvTopRated);
  });

  test('the initial state should be empty', () {
    expect(tvTopRatedBloc.state, TelevisionTopRatedEmpty());
  });

  blocTest<TelevisionTopRatedBloc, TelevisionTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionTopRated()),
    expect: () => [
      TelevisionTopRatedLoading(),
      TelevisionTopRatedHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvTopRated.execute());
      return OnTelevisionTopRated().props;
    },
  );

  blocTest<TelevisionTopRatedBloc, TelevisionTopRatedState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionTopRated()),
    expect: () => [
      TelevisionTopRatedLoading(),
      TelevisionTopRatedError('Server Failure'),
    ],
    verify: (bloc) => TelevisionTopRatedLoading(),
  );

  blocTest<TelevisionTopRatedBloc, TelevisionTopRatedState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Right([]));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionTopRated()),
    expect: () => [
      TelevisionTopRatedLoading(),
      TelevisionTopRatedEmpty(),
    ],
  );
}
