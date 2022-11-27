import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularTv mockGetTvPopular;
  late TelevisionPopularBloc tvPopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetPopularTv();
    tvPopularBloc = TelevisionPopularBloc(mockGetTvPopular);
  });

  test('the initial state should be empty', () {
    expect(tvPopularBloc.state, TelevisionPopularEmpty());
  });

  blocTest<TelevisionPopularBloc, TelevisionPopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionPopular()),
    expect: () => [
      TelevisionPopularLoading(),
      TelevisionPopularHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvPopular.execute());
      return OnTelevisionPopular().props;
    },
  );

  blocTest<TelevisionPopularBloc, TelevisionPopularState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionPopular()),
    expect: () => [
      TelevisionPopularLoading(),
      TelevisionPopularError('Server Failure'),
    ],
    verify: (bloc) => TelevisionPopularLoading(),
  );

  blocTest<TelevisionPopularBloc, TelevisionPopularState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvPopular.execute()).thenAnswer((_) async => const Right([]));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionPopular()),
    expect: () => [
      TelevisionPopularLoading(),
      TelevisionPopularEmpty(),
    ],
  );
}
