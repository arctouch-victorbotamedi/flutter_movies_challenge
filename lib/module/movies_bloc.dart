import 'dart:async';
import 'dart:math';

import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/model/movie_page.dart';
import 'package:movies_challenge/module/movies_slice.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesBloc {

  static const _itemsPerPage = 20;

  final _movieRepository = TmdbMovieRepository();
  final _pages = <int, MoviePage>{};
  final _indexController = PublishSubject<int>();

  final _pagesBeingRequested = Set<int>();

  final _sliceSubject = BehaviorSubject<MoviesSlice>();

  MoviesBloc() {
    _indexController.stream
        .bufferTime(Duration(milliseconds: 500))
        .where((batch) => batch.isNotEmpty)
        .listen(_handleIndexes);
  }

  Sink<int> get index => _indexController.sink;

  Stream<MoviesSlice> get slice => _sliceSubject.stream;

  Future<List<Actor>> cast(Movie movie) => _movieRepository.fetchCast(movie);

  int _getPageStartFromIndex(int index) =>
      (index ~/ _itemsPerPage) * _itemsPerPage;

  void _handleIndexes(List<int> indexes) {
    const maxInt = 0x7fffffff;
    final int minIndex = indexes.fold(maxInt, min);
    final int maxIndex = indexes.fold(-1, max);

    final minPageIndex = _getPageStartFromIndex(minIndex);
    final maxPageIndex = _getPageStartFromIndex(maxIndex);

    for (int i = minPageIndex; i <= maxPageIndex; i += _itemsPerPage) {
      final pageIndex = i ~/ _itemsPerPage;

      if (_pages.containsKey(pageIndex) || _pagesBeingRequested.contains(pageIndex))
        continue;

      _pagesBeingRequested.add(pageIndex);
      _requestPage(pageIndex)
          .then((page) => _handleNewPage(page, pageIndex));
    }

    // Remove pages too far from current scroll position.
    //_pages.removeWhere((pageIndex, _) =>
    //  pageIndex < minPageIndex - _itemsPerPage ||
    //      pageIndex > maxPageIndex + _itemsPerPage);
  }

  void _handleNewPage(MoviePage page, int index) {
    _pages[index] = page;
    _pagesBeingRequested.remove(index);
    _sendNewSlice();
  }

  Future<MoviePage> _requestPage(int index) async {
    var movies = await _movieRepository
        .fetchUpcomingMovies(index + 1);
    return MoviePage(movies, _itemsPerPage * index);
  }

  void _sendNewSlice() {
    final pages = _pages.values.toList(growable: false);
    final slice = MoviesSlice(pages, true);
    _sliceSubject.add(slice);
  }
}
