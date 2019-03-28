import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movie_state.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  static const itemsPerPage = 20;
  final MovieRepository movieRepository;

  MoviesBloc(this.movieRepository);

  @override
  MovieState get initialState => UninitializedState();

  @override
  Stream<MovieEvent> transform(Stream<MovieEvent> events) {
    return (events as Observable<MovieEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is UninitializedState) {
          final movies = await movieRepository.fetchUpcomingMovies(1);
          yield MoviesLoadedState(movies: movies, hasReachedMax: false);
          return;
        }
        if (currentState is MoviesLoadedState) {
          var state = currentState as MoviesLoadedState;
          var page = ((state.movies.length / itemsPerPage) + 1).toInt();
          final movies = await movieRepository.fetchUpcomingMovies(page);
          yield movies.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : MoviesLoadedState(
              movies: state.movies + movies, hasReachedMax: false);
        }
      } catch (_) {
        yield ErrorState();
      }
    }
  }

  bool _hasReachedMax(MovieState state) =>
      state is MoviesLoadedState && state.hasReachedMax;
}
