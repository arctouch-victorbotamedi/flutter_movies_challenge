import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/module/movies_slice.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';
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
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final moviesBloc = MoviesProvider.of(context);
    if (!_hasInternetConenction() && moviesBloc.isEmpty)
      return _buildNoInternetConnectionWidget();
    return _buildMovies(context, moviesBloc);
  }

  Widget _buildMovies(BuildContext context, MoviesBloc moviesBloc) {
    return StreamBuilder<MoviesSlice>(
      stream: moviesBloc.slice,
      initialData: MoviesSlice.empty(),
      builder: (context, snapshot) =>
          ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                // Add a one-pixel-high divider widget before each row in theListView.
                if (i.isOdd)
                  return Divider();

                // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
                // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
                // This calculates the actual number of word pairings in the ListView,
                // minus the divider widgets.
                final index = i ~/ 2;
                moviesBloc.index.add(index);

                var movie = snapshot.data.elementAt(index);
                if (null == movie)
                  return Center(child: CircularProgressIndicator());

                return MovieListItem(movie);
              }),
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
