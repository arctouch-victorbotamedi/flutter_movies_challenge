import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movie_state.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_challenge/view/providers/movies_provider.dart';


class MovieList extends StatelessWidget {
  final _scrollThresholdPercentage = 70;

  @override
  Widget build(BuildContext context) {
    var moviesBloc = DependencyProvider.moviesBlocOf(context);
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
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  var currentPercentage =  (index * 100) / state.movies.length;
                  if (currentPercentage >= _scrollThresholdPercentage) {
                    moviesBloc.dispatch(Fetch());
                  }
                  return index >= state.movies.length
                      ? BottomLoader()
                      : MovieListItem(state.movies[index]);
                },
              );
            default:
              return Center(child: Text('failed to fetch posts'));
          }
        }
    );
  }

  Widget _buildNoInternetConnectionWidget() {
    return Center(
      child: Text("No Internet Connection"),
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

