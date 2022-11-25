import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/movie_bloc_search/search_movie_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchBloc searchBLoc;
  late MockSearchMovies mockSearchMovie;

  setUp(() {
    mockSearchMovie = MockSearchMovies();
    searchBLoc = SearchBloc(mockSearchMovie);
  });

  test("Initial state should be empty", () {
    expect(searchBLoc.state, SearchEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  blocTest<SearchBloc, SearchState>(
      "should emit [Loading, HasData] when data is gotter successfully",
      build: () {
        when(mockSearchMovie.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBLoc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchLoading(),
            SearchHasData(tMovieList),
          ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(tQuery));
      });

  blocTest<SearchBloc, SearchState>(
      "should emit [Loading, Error] when get search is unsuccessfull",
      build: () {
        when(mockSearchMovie.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure("Server Failure")));
        return searchBLoc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchLoading(),
            const SearchError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(tQuery));
      });
}
