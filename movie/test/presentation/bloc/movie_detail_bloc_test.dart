import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MoviesDetailBloc movieDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MoviesDetailBloc(mockGetMovieDetail);
  });

  test('the initial state should be empty', () {
    expect(movieDetailBloc.state, MoviesDetailEmpty());
  });
  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnMoviesDetail(testId)),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testId));
      return OnMoviesDetail(testId).props;
    },
  );

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnMoviesDetail(testId)),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailError('Server Failure'),
    ],
    verify: (bloc) => MoviesDetailLoading(),
  );
}
