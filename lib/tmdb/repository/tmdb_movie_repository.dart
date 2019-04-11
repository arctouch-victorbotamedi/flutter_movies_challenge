import 'dart:async';

import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/genre.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_api.dart';

class TmdbMovieRepository implements MovieRepository {
  final TmdbMovieApi api;

  TmdbMovieRepository(this.api);

  @override
  Future<List<Movie>> fetchUpcomingMovies([int page = 1]) {
    return api.fetchUpcomingMovies(page);
  }

  @override
  Future<List<Actor>> fetchCast(Movie movie) {
    return api.fetchCast(movie.id);
  }

  Future<List<Genre>> fetchGenres() {
    return api.fetchGenres();
  }

  @override
  Future<List<Movie>> searchMovies(String query, [int page = 1]) {
    return api.searchMovies(query, page);
  }
}
