import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movie_state.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MovieList extends StatelessWidget {
  final _scrollThresholdPercentage = 70;

  @override
  Widget build(BuildContext context) {
    var moviesBloc = BlocProvider.of<MoviesBloc>(context);
    return _buildMovies(context, moviesBloc);
  }

  Widget _buildMovies(BuildContext context, MoviesBloc moviesBloc) {
    return BlocBuilder(
        bloc: moviesBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case UninitializedState:
              return Center(child: CircularProgressIndicator());
            case NoInternetConnectionState:
              return _buildNoInternetConnectionWidget();
            case MoviesLoadedState:
              return _buildMoviesListWidget(moviesBloc, state);
            case OfflineDataState:
              return _buildOfflineMoviesListWidget(state);
            default:
              return Center(child: Text('Failed to fetch movies'));
          }
        }
    );
  }

  Widget _buildNoInternetConnectionWidget() {
    return Center(
      child: Text("No Internet Connection"),
    );
  }

  Widget _buildMoviesListWidget(MoviesBloc bloc, MoviesLoadedState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        var currentPercentage =  (index * 100) / state.movies.length;
        if (currentPercentage >= _scrollThresholdPercentage) {
          bloc.dispatch(Fetch());
        }
        return index >= state.movies.length
            ? BottomLoader()
            : MovieListItem(state.movies[index]);
      },
    );
  }

  Widget _buildOfflineMoviesListWidget(OfflineDataState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        return index >= state.movies.length
            ? BottomLoader()
            : MovieListItem(state.movies[index]);
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

