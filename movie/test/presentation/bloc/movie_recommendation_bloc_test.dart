import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MoviesTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MoviesTopRatedBloc(mockGetTopRatedMovies);
  });

  test('the initial state should be empty', () {
    expect(movieTopRatedBloc.state, MoviesTopRatedEmpty());
  });

  blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnMoviesTopRated()),
    expect: () => [
      MoviesTopRatedLoading(),
      MoviesTopRatedHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return OnMoviesTopRated().props;
    },
  );

  blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnMoviesTopRated()),
    expect: () => [
      MoviesTopRatedLoading(),
      MoviesTopRatedError('Server Failure'),
    ],
    verify: (bloc) => MoviesTopRatedLoading(),
  );

  blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnMoviesTopRated()),
    expect: () => [
      MoviesTopRatedLoading(),
      MoviesTopRatedEmpty(),
    ],
  );
}
