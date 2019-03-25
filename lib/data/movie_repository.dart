import 'dart:async';

import 'package:movies_challenge/model/movie.dart';


abstract class MovieRepository {
  Future<List<Movie>> fetchUpcomingMovies([int page=1]);
}