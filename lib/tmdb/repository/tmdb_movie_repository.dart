import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/tmdb/api_constants.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/tmdb/model/movie_collection.dart';


class TmdbMovieRepository implements MovieRepository {

  static const maxPages = 1000;

  static const _tmdbKey = "1f54bd990f1cdfb230adb312546d765d";

  @override
  Future<List<Movie>> fetchUpcomingMovies([int page = 1]) {
    final resource = '3/discover/movie';
    final now = new DateTime.now().toIso8601String();
    var httpClient = new HttpClient();
    var uri = new Uri.https(ApiBaseUri, resource, {
      'api_key': _tmdbKey,
      'page': page.toString(),
      'language': 'en-US',
      'sort_by': 'primary_release_date.asc',
      'include_adult': 'false',
      'include_video': 'false',
      'primary_release_date.gte': now,
    });

    return httpClient.getUrl(uri)
      .then((request) async {
        var response = await request.close();
        if (response.statusCode == HttpStatus.OK) {
          var data = await response.transform(utf8.decoder).join();
          var movies = new MovieCollection.fromJson(jsonDecode(data));
          return movies.results;
        }
      },
      onError: (error, stacktrace) {

      });
  }
}
