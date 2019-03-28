import 'package:equatable/equatable.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';

abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class UninitializedState extends MovieState {
  @override
  String toString() => 'UninitializedState';
}

class ErrorState extends MovieState {
  @override
  String toString() => 'ErrorState';
}

class MoviesLoadedState extends MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  MoviesLoadedState({
    this.movies,
    this.hasReachedMax,
  }) : super([movies, hasReachedMax]);

  MoviesLoadedState copyWith({
    List<Movie> movies,
    bool hasReachedMax,
  }) {
    return MoviesLoadedState(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'MoviesLoaded { movies: ${movies.length}, hasReachedMax: $hasReachedMax }';
}

class MovieCastLoadedState extends MovieState {
  final List<Actor> cast;

  MovieCastLoadedState(this.cast)
      : super([cast]);

  @override
  String toString() =>
      'MovieCastLoaded { cast: ${cast.length} }';
}
