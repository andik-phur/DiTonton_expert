import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviesPopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviesPopularBloc(mockGetPopularMovies);
  });

  test('the initial state should be empty', () {
    expect(moviePopularBloc.state, MoviesPopularEmpty());
  });

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnMoviesPopular()),
    expect: () => [
      MoviesPopularHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return OnMoviesPopular().props;
    },
  );

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnMoviesPopular()),
    expect: () => [
      MoviesPopularError('Server Failure'),
    ],
    verify: (bloc) => MoviesPopularLoading(),
  );

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnMoviesPopular()),
    expect: () => [
      MoviesPopularEmpty(),
    ],
  );
}
