import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

import '../../movie_test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MoviesWatchListBloc movieWatchListBloc;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchListBloc = MoviesWatchListBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(movieWatchListBloc.state, MoviesWatchListInitial());
  });

  group(
    'get watchlist movies test cases',
    () {
      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMoviesWatchList()),
        expect: () => [
          MoviesWatchListLoading(),
          MoviesWatchListHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
          return OnFetchMoviesWatchList().props;
        },
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMoviesWatchList()),
        expect: () => [
          MoviesWatchListLoading(),
          MoviesWatchListError('Server Failure'),
        ],
        verify: (bloc) => MoviesWatchListLoading(),
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMoviesWatchList()),
        expect: () => [
          MoviesWatchListLoading(),
          MoviesWatchListEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MoviesWatchListIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MoviesWatchListStatus(testMovieDetail.id).props;
        },
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MoviesWatchListIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MoviesWatchListStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("addMessage"));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListAdd(testMovieDetail)),
        expect: () => [
          MoviesWatchListMessage("addMessage"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return MoviesWatchListAdd(testMovieDetail).props;
        },
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListAdd(testMovieDetail)),
        expect: () => [
          MoviesWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return MoviesWatchListAdd(testMovieDetail).props;
        },
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("removeMessage"));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListRemove(testMovieDetail)),
        expect: () => [
          MoviesWatchListMessage("removeMessage"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return MoviesWatchListRemove(testMovieDetail).props;
        },
      );

      blocTest<MoviesWatchListBloc, MoviesWatchListState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MoviesWatchListRemove(testMovieDetail)),
        expect: () => [
          MoviesWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return MoviesWatchListRemove(testMovieDetail).props;
        },
      );
    },
  );
}
