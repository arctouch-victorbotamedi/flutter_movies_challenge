import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/module/search_event.dart';
import 'package:movies_challenge/module/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository movieRepository;

  SearchBloc(this.movieRepository);

  @override
  SearchState get initialState => UninitializedState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchEvent) {
      if (event.movieName.length < 3)
        yield currentState;

      var movies = await movieRepository.searchMovies(event.movieName, 1);
      if (movies.isEmpty)
        yield SearchNoResultsState(event.movieName);
      else
        yield MoviesLoadedSearchResultState(movies, event.movieName);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
