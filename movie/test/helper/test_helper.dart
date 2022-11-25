import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  GetMovieDetail,
  GetPopularMovies,
  GetNowPlayingMovies,
  GetTopRatedMovies,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
