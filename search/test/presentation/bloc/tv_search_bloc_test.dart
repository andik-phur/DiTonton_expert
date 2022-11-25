import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:dartz/dartz.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([TvSearch])
void main() {
  late SearchBlocTv searchBloc;
  late MockTvSearch mockSearchTv;

  setUp(() {
    mockSearchTv = MockTvSearch();
    searchBloc = SearchBlocTv(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmptyTv());
  });

  final tTVModel = Television(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: const [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: const ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765);
  final tTVList = <Television>[tTVModel];
  const tQuery = 'Pasión de gavilanes';

  blocTest<SearchBlocTv, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchBlocTv, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      const SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
