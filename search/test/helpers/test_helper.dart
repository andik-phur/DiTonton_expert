import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:core/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TvRepository,
  MovieRepository,
])
void main() {}
