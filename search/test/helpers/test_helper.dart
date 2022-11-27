import 'package:mockito/annotations.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  TvRepository,
  MovieRepository,
])
void main() {}
