import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/movie_detail_page.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';

class MovieListItem extends StatelessWidget {
  final Movie _movie;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  MovieListItem(this._movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: () => _navigateToMovieDetails(context),
          highlightShape: BoxShape.rectangle,
          child: Container(
            child: Row(
              children: [
                PosterHero(
                  tag: _movie.id.toString(),
                  image: _movie.posterUrl,
                  height: 100.0,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_movie.title,
                                style: _biggerFont,
                                overflow: TextOverflow.fade),
                            Text(_formateReleaseDate(_movie)),
                            Text(_formatGenres(_movie),
                                overflow: TextOverflow.fade)
                          ],
                        )))
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  String _formatGenres(Movie movie) {
    var genres = movie.genres.map((genre) => genre.name);
    return genres.join('| ');
  }

  String _formateReleaseDate(Movie movie) {
    var date = DateFormat('MM/dd/yyyy').format(movie.releaseDate);
    return "Release $date";
  }

  void _navigateToMovieDetails(BuildContext context) {
    var moviesBloc = BlocProvider.of<MoviesBloc>(context);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            MovieDetailPage(moviesBloc.movieRepository, _movie)
        )
    );
  }
}
