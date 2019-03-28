import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movie_state.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_challenge/view/providers/movies_provider.dart';


class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoviesListHomePageState();
  }
}

class _MoviesListHomePageState extends State<MovieList> {

  StreamSubscription _subscription;
  ConnectivityResult _connectivityStatus;
  final _scrollThresholdPercentage = 70;

  _MoviesListHomePageState();

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      _connectivityStatus = result;
      setState(() => _connectivityStatus = result);
      _subscription = Connectivity().onConnectivityChanged.listen(
              (ConnectivityResult result) {
                if (_connectivityStatus != result)
                  setState(() => _connectivityStatus = result);
              });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var moviesBloc = DependencyProvider.moviesBlocOf(context);
    // moviesBloc.dispatch(Fetch());

    //if (!_hasInternetConenction() && moviesBloc.isEmpty)
    //  return _buildNoInternetConnectionWidget();
    return _buildMovies(context, moviesBloc);
  }

  Widget _buildMovies(BuildContext context, MoviesBloc moviesBloc) {
    return BlocBuilder(
      bloc: moviesBloc,
      builder: (context, state) {
        if (state is UninitializedState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is MoviesLoadedState) {
          if (state.movies.isEmpty) {
            return Center(
              child: Text('No movies'),
            );
          }
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
        }
      }
    );
  }

  Widget _buildNoInternetConnectionWidget() {
    return Center(
      child: Text("No Internet Connection"),
    );
  }

  bool _hasInternetConenction() {
    return _connectivityStatus != null && _connectivityStatus != ConnectivityResult.none;
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

