import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetDetailTv mockGetTvDetail;
  late DetailTvBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvDetail = MockGetDetailTv();
    tvDetailBloc = DetailTvBloc(mockGetTvDetail);
  });

  test('the initial state should be empty', () {
    expect(tvDetailBloc.state, TelevisionDetailEmpty());
  });

  blocTest<DetailTvBloc, DetailTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnTelevisionDetail(testId)),
    expect: () => [
      TelevisionDetailLoading(),
      TelevisionDetailError('Server Failure'),
    ],
    verify: (bloc) => TelevisionDetailLoading(),
  );
}
