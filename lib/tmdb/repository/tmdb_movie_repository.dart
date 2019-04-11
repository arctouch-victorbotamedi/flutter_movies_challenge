import 'dart:async';

import 'package:movies_challenge/data/cache/cache_database_provider.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/tmdb/model/genre.dart';
import 'package:movies_challenge/tmdb/model/movie.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_api.dart';

class TmdbMovieRepository implements MovieRepository {
  static const _genresCacheKey = 'GenresCache';
  static const _moviesCacheKey = 'MoviesCache';

  final TmdbMovieApi api;
  final CacheDatabaseProvider cache;

  List<TmdbGenre> _genres;
  
  TmdbMovieRepository(this.api, this.cache) {
    cache.get(_genresCacheKey).then((cachedGenres) {
      if (cachedGenres != null) {
        var genres = cachedGenres as List<dynamic>;
        _genres = genres.map((genre) => TmdbGenre.fromJson(genre)).toList();
      }
      else
        print('No genres in cache');
      api.fetchGenres().then((genres) {
        _genres = genres;
        cache.insert(_genresCacheKey, genres);
      });
    });
  }

  @override
  Future<List<Movie>> fetchUpcomingMovies([int page = 1]) async {
    if (_genres == null) 
      _genres = await api.fetchGenres();

    var movies = await api.fetchUpcomingMovies(page);
    _setMovieGenres(movies);
    return movies;
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

  void _setMovieGenres(List<TmdbMovie> movies) {
    movies.forEach((movie) => movie.genres = _genres
        .where((genre) => movie.genreIds.any((id) => id == genre.id))
        .toList()
    );
  }
}
