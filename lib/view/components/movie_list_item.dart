import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/components/skeleton.dart';
import 'package:movies_challenge/view/movie_detail_page.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';

class MovieListItem extends StatelessWidget {
  final Movie _movie;
  bool get isLoaded => _movie != null;

  MovieListItem(this._movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: () => _navigateToMovieDetails(context),
          highlightShape: BoxShape.rectangle,
          child:
          SizedBox(
            height: 110,
            child: Row(
            children: [
              Skeleton(
                itemBuilder: (context) => PosterHero(
                   tag: _movie.id.toString(),
                   image: _movie.posterUrl,
                   height: 100.0,
                 ),
                 isLoaded: isLoaded,
                 width: 70,
                 height: 100
              ),
              _buildInformationWidget(context)
            ],
          ),
        )),
        Divider()
      ],
    );
  }

  Widget _buildInformationWidget(BuildContext context) {
    var theme = Theme.of(context);
    return  Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(
              itemBuilder: (context) => Text(_movie.title,
                  style: theme.textTheme.title,
                  overflow: TextOverflow.fade),
              isLoaded: isLoaded,
              width: 300,
              height: theme.textTheme.title.fontSize
            ),
            Skeleton(
                itemBuilder: (context) => Text(_formateReleaseDate(_movie)),
                isLoaded: isLoaded,
                width: 150,
                height: theme.textTheme.body1.fontSize
            ),
            Skeleton(
                itemBuilder: (context) => Text(_formatGenres(_movie),
                    overflow: TextOverflow.fade),
                isLoaded: isLoaded,
                width: 200,
                height: theme.textTheme.body1.fontSize
            ),
          ],
        )
      )
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
    if (!isLoaded)
      return;
    var moviesBloc = BlocProvider.of<MoviesBloc>(context);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            MovieDetailPage(moviesBloc.movieRepository, _movie)
        )
    );
  }
}

