import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/model/page.dart';
import 'package:movies_challenge/tmdb/model/movie.dart';


class MovieCollection implements Page<Movie> {
  @override
  int totalResults;
  @override
  int totalPages;
  @override
  int page;
  @override
  List<Movie> results;

  MovieCollection();

  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      new MovieCollection()
        ..totalResults = json['total_results'] as int
        ..totalPages = json['total_pages'] as int
        ..results = (json['results'] as List)
            ?.map((e) => e == null ? null : TmdbMovie.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() => {
    'total_results': totalResults,
    'total_pages': totalPages,
    'page': page,
    'results': results.map((item)=> (item as TmdbMovie).toJson()).toList(),
  };
}
