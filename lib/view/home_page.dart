import 'package:flutter/material.dart';
import 'package:movies_challenge/module/movies_slice.dart';
import 'package:movies_challenge/view/components/movie_list_item.dart';
import 'package:movies_challenge/view/providers/movies_provider.dart';


class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Movies'),
      ),
      body: _buildMovies(context),
    );
  }

  Widget _buildMovies(BuildContext context) {
    final moviesBloc = MoviesProvider.of(context);

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
}
