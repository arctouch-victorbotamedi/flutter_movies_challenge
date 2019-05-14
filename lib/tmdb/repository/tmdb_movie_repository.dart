import 'dart:async';

import 'package:movies_challenge/data/cache/cache.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/model/page.dart';
import 'package:movies_challenge/tmdb/model/genre.dart';
import 'package:movies_challenge/tmdb/model/movie.dart';
import 'package:movies_challenge/tmdb/model/movie_collection.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_api.dart';

class TmdbMovieRepository implements MovieRepository {
  static const _genresCacheKey = 'GenresCache';
  static const _moviesCacheKey = 'MoviesCache';

  final TmdbMovieApi api;
  final Cache cache;

  List<TmdbGenre> _genres;
  
  TmdbMovieRepository(this.api, this.cache) {
    cache.fetchList<TmdbGenre>(_genresCacheKey, api.fetchGenres, (obj) => TmdbGenre.fromJson(obj))
        .listen((genres) => _genres = genres)
        .onError((ex, stack) => print(ex));
  }

  @override
  Stream<Page<Movie>> fetchUpcomingMovies([int page = 1]) {
    return cache.fetchObject<Page<Movie>>(
        '$_moviesCacheKey-$page',
        () async {
          var resultPage = await api.fetchUpcomingMovies(page);
          _setMovieGenres(resultPage.results);
          return resultPage;
        },
        (obj) {
          var resultPage = MovieCollection.fromJson(obj)
            ..page = page;
          _setMovieGenres(resultPage.results);
          return resultPage;
        });
  }

  @override
  Future<List<Actor>> fetchCast(Movie movie) {
    return api.fetchCast(movie.id);
  }

  @override
  Future<List<Movie>> searchMovies(String query, [int page = 1]) async {
    if (_genres == null)
      _genres = await api.fetchGenres();
    var movies = await api.searchMovies(query, page);
    _setMovieGenres(movies);
    return movies;
  }

  void _setMovieGenres(List<Movie> movies) {
    movies.forEach(_setMovieGenre);
  }

  void _setMovieGenre(Movie movie) {
    if (_genres == null)
      return;
    var tmdbMovie = movie as TmdbMovie;
    tmdbMovie.genres = _genres
      .where((genre) => tmdbMovie.genreIds.any((id) => id == genre.id))
      .toList();
  }
}
