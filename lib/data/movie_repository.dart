import 'dart:async';

import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';


abstract class MovieRepository {
  Future<List<Movie>> fetchUpcomingMovies([int page=1]);
  Future<List<Actor>> fetchCast(Movie movie);
  Future<List<Movie>> searchMovies(String keyword, [int page=1]);
}