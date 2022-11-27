import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';

import '../../tv_test/dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTvRecommendations mockGetRecommendationsTv;
  late TvRecommendationBloc tvRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetRecommendationsTv = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(mockGetRecommendationsTv);
  });

  test("the initial state should be empty", () {
    expect(tvRecommendationBloc.state, TelevisionRecommendationEmpty());
  });

  blocTest<TvRecommendationBloc, TelevisionRecommendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => Right(testTVShowList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionRecommendation(testId)),
    expect: () => [
      TelevisionRecommendationLoading(),
      TelevisionRecommendationHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationsTv.execute(testId));
      return OnTelevisionRecommendation(testId).props;
    },
  );

  blocTest<TvRecommendationBloc, TelevisionRecommendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionRecommendation(testId)),
    expect: () => [
      TelevisionRecommendationLoading(),
      TelevisionRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TelevisionRecommendationLoading(),
  );

  blocTest<TvRecommendationBloc, TelevisionRecommendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionRecommendation(testId)),
    expect: () => [
      TelevisionRecommendationLoading(),
      TelevisionRecommendationEmpty(),
    ],
  );
}
