import 'dart:math';

import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/model/movie_page.dart';

class MoviesSlice {

  final List<MoviePage> _pages;

  final int startIndex;
  final bool hasNext;

  MoviesSlice(this._pages, this.hasNext)
    : startIndex = _pages.map((page) => page.startIndex).fold(0x7FFFFFFF, min);

  const MoviesSlice.empty()
    : _pages = const [],
      startIndex = 0,
      hasNext = true;

  int get endIndex =>
    startIndex + _pages.map((page) => page.endIndex).fold(-1, max);

  Movie elementAt(int index) {
    for (final page in _pages) {
      if (index >= page.startIndex && index <= page.endIndex) {
        return page.movies[index - page.startIndex];
      }
    }
    return null;
  }
}