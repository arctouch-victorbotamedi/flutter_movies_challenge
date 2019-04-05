import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/genre.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/tmdb/api_constants.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/tmdb/model/credits.dart';
import 'package:movies_challenge/tmdb/model/genre_collection.dart';
import 'package:movies_challenge/tmdb/model/movie_collection.dart';

class TmdbMovieRepository implements MovieRepository {
  static const maxPages = 1000;
  static const _tmdbKey = "1f54bd990f1cdfb230adb312546d765d";

  List<Genre> _genres;

  @override
  Future<List<Movie>> fetchUpcomingMovies([int page = 1]) async {
    if (_genres == null) _genres = await fetchGenres();

    final resource = '3/discover/movie';
    final now = DateTime.now().toIso8601String();
    var httpClient = HttpClient();
    var uri = Uri.https(ApiBaseUri, resource, {
      'api_key': _tmdbKey,
      'page': page.toString(),
      'language': 'en-US',
      'sort_by': 'primary_release_date.asc',
      'include_adult': 'false',
      'include_video': 'false',
      'primary_release_date.gte': now,
    });

    return httpClient.getUrl(uri).then((request) async {
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var data = await response.transform(utf8.decoder).join();
        var movies = MovieCollection.fromJson(jsonDecode(data), _genres);
        return movies.results;
      }
    }, onError: (error, stacktrace) {});
  }

  @override
  Future<List<Actor>> fetchCast(Movie movie) {
    final resource = '3/movie/${movie.id}/credits';
    var httpClient = HttpClient();
    var uri = Uri.https(ApiBaseUri, resource, {
      'api_key': _tmdbKey,
    });

    return httpClient.getUrl(uri).then((request) async {
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var data = await response.transform(utf8.decoder).join();
        var credits = Credits.fromJson(jsonDecode(data));
        return credits.cast;
      }
    }, onError: (error, stacktrace) {});
  }

  Future<List<Genre>> fetchGenres() {
    final resource = '3/genre/movie/list';
    var httpClient = HttpClient();
    var uri = Uri.https(ApiBaseUri, resource, {
      'api_key': _tmdbKey,
      'language': 'en-US',
    });
    return httpClient.getUrl(uri).then((request) async {
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var data = await response.transform(utf8.decoder).join();
        var genres = GenreCollection.fromJson(jsonDecode(data));
        return genres.results;
      }
    }, onError: (error, stacktrace) {});
  }

  @override
  Future<List<Movie>> searchMovies(String keyword, [int page = 1]) async {
    if (_genres == null)
      _genres = await fetchGenres();

    final resource = '3/search/movie';
    var httpClient = HttpClient();
    var uri = Uri.https(ApiBaseUri, resource, {
      'api_key': _tmdbKey,
      'page': page.toString(),
      'query': keyword,
      'language': 'en-US',
      'include_adult': 'false',
    });

    return httpClient.getUrl(uri)
        .then((request) async {
          var response = await request.close();
          if (response.statusCode == HttpStatus.ok) {
            var data = await response.transform(utf8.decoder).join();
            var movies = MovieCollection.fromJson(jsonDecode(data), _genres);
            return movies.results;
          }
        },
        onError: (error, stacktrace) {

        });
  }
}
