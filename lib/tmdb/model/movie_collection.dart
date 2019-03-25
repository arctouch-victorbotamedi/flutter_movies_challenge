import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/tmdb/model/movie.dart';


class MovieCollection {

  int totalResults;
  int totalPages;
  List<Movie> results;

  MovieCollection();

  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      new MovieCollection()
        ..totalResults = json['total_results'] as int
        ..totalPages = json['total_pages'] as int
        ..results = (json['results'] as List)
            ?.map((e) => e == null ? null : new TmdbMovie.fromJson(e as Map<String, dynamic>))
            ?.toList();
}
