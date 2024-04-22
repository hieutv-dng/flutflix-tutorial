import 'package:flutflix/constants.dart';
import 'package:flutflix/data/index.dart';

import 'movie_service.dart';

class MovieApi {
  final _service = MovieService.create();

  Future<List<Movie>> getTrendingMovies() {
    return _service.trendingMovies(Constants.apiKey).then(
      (httpResponse) {
        return httpResponse.data.results;
      },
    );
  }

  Future<List<Movie>> getTopRatedMovies() {
    return _service.topRatedMovies(Constants.apiKey).then(
      (httpResponse) {
        return httpResponse.data.results;
      },
    );
  }

  Future<List<Movie>> getUpcomingMovies() {
    return _service.upcomingMovies(Constants.apiKey).then(
      (httpResponse) {
        return httpResponse.data.results;
      },
    );
  }
}
