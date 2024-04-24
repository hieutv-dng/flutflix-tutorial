import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutflix/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_utils.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class MovieResponse with _$MovieResponse {
  factory MovieResponse({
    @JsonKey(name: 'results') @Default([]) List<Movie> results,
  }) = _MovieResponse;
  const MovieResponse._();

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}

@freezed
class Movie with _$Movie {
  factory Movie({
    @JsonKey(name: 'id', fromJson: $fromJsonToString) @Default('') String id,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'overview') @Default('') String overview,
    @JsonKey(name: 'poster_path') @Default('') String posterPath,
    @JsonKey(name: 'release_date') @Default('') String releaseDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'timestamp') int? timestamp,
  }) = _Movie;
  const Movie._();

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  String get posterPathUrl => '${Constants.imagePath}$posterPath';
}
