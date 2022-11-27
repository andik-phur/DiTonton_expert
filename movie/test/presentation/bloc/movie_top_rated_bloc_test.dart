import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/recommendation_movies/recommendation_movies_bloc.dart';

import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MoviesRecommendationBloc movieRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MoviesRecommendationBloc(mockGetMovieRecommendations);
  });

  test('the initial state should be empty', () {
    expect(movieRecommendationBloc.state, MoviesRecommendationEmpty());
  });

  blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnMoviesRecommendation(testId)),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testId));
      return OnMoviesRecommendation(testId).props;
    },
  );

  blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnMoviesRecommendation(testId)),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationError('Server Failure'),
    ],
    verify: (bloc) => MoviesRecommendationLoading(),
  );

  blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnMoviesRecommendation(testId)),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationEmpty(),
    ],
  );
}
