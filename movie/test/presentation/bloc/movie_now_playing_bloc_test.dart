import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';

import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MoviesNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MoviesNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('the initial state should be empty', () {
    expect(movieNowPlayingBloc.state, MoviesNowPlayingEmpty());
  });

  blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnMoviesNowPLayingCalled()),
    expect: () => [
      MoviesNowPlayingLoading(),
      MoviesNowPlayingHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return OnMoviesNowPLayingCalled().props;
    },
  );

  blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnMoviesNowPLayingCalled()),
    expect: () => [
      MoviesNowPlayingLoading(),
      const MoviesNowPlayingError('Server Failure'),
    ],
    verify: (bloc) => MoviesNowPlayingLoading(),
  );

  blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnMoviesNowPLayingCalled()),
    expect: () => [
      MoviesNowPlayingLoading(),
      MoviesNowPlayingEmpty(),
    ],
  );
}
