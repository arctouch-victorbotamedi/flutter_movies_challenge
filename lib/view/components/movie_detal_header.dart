import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/view/components/arc_image.dart';
import 'package:movies_challenge/view/components/movie_rating.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';


class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this._movie);
  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _movie.title,
          style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        MovieRating(_movie),
        SizedBox(height: 12.0),
        Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcImage(_movie.backdropUrl, 230),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PosterHero(
                tag: _movie.id.toString(),
                image: _movie.posterUrl,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return _movie.genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genre.name),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }
}