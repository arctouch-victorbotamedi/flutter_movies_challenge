

import 'dart:collection';

import 'package:movies_challenge/model/movie.dart';

class MoviePage {

  final List<Movie> _movies;
  final int startIndex;

  MoviePage(this._movies, this.startIndex);

  int get count => _movies.length;
  int get endIndex => startIndex + count - 1;

  UnmodifiableListView<Movie> get movies =>
      UnmodifiableListView<Movie>(_movies);

  @override
  String toString() => "_MoviePage($startIndex-$endIndex)";
}
