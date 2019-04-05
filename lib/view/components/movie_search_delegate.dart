

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_challenge/module/search_bloc.dart';
import 'package:movies_challenge/module/search_event.dart';
import 'package:movies_challenge/module/search_state.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';

class MovieSearchDelegate extends SearchDelegate {

  final EdgeInsets _movieListPadding = const EdgeInsets.all(16.0);

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    var headlineStyle = theme.textTheme.title.copyWith(color: Colors.white);
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(title: headlineStyle)
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildResults(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.dispatch(SearchEvent(query));
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    var searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder(
        bloc: searchBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case UninitializedState:
              return _buildUninitialized();
            case MoviesLoadedSearchResultState:
              return _buildMoviesList(searchBloc, state);
            default:
              return Center(child: Text('Failed to fetch movies'));
          }
        }
    );
  }

  Widget _buildMoviesList(SearchBloc bloc, MoviesLoadedSearchResultState state) {
    return ListView.builder(
      padding: _movieListPadding,
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        return  MovieListItem(state.movies[index]);
      },
    );
  }

  Widget _buildUninitialized() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Search term must be longer than two letters.",
          ),
        )
      ],
    );
  }
}
