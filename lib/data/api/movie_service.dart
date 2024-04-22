import 'package:dio/dio.dart';
import 'package:flutflix/data/index.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio, {String baseUrl}) = _MovieService;

  @GET('https://api.themoviedb.org/3/trending/movie/day')
  Future<HttpResponse<MovieResponse>> trendingMovies(
    @Query('api_key') String apiKey,
  );

  @GET('https://api.themoviedb.org/3/movie/top_rated')
  Future<HttpResponse<MovieResponse>> topRatedMovies(
    @Query('api_key') String apiKey,
  );

  @GET('https://api.themoviedb.org/3/movie/upcoming')
  Future<HttpResponse<MovieResponse>> upcomingMovies(
    @Query('api_key') String apiKey,
  );

  static MovieService create() {
    final client = MovieService(Dio());
    return client;
  }
}
