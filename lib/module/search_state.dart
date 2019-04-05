import 'package:equatable/equatable.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';

abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class UninitializedState extends SearchState {
  @override
  String toString() => 'UninitializedState';
}

class MoviesLoadedSearchResultState extends SearchState {
  final List<Movie> movies;
  final String searchKeyword;

  MoviesLoadedSearchResultState(this.movies, this.searchKeyword)
      : super([movies, searchKeyword]);

  @override
  String toString() =>
      'MovieasLoadedSearchResultState { movies: ${movies.length}, keyword: $searchKeyword}';
}

class SearchNoResultsState extends SearchState {
  final String searchKeyword;

  SearchNoResultsState(this.searchKeyword)
      : super([searchKeyword]);

  @override
  String toString() =>
      'SearchNoResultsState { keyword: $searchKeyword}';
}
