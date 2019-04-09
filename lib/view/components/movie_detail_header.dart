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
    var theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PosterHero(
          tag: _movie.id.toString(),
          image: _movie.posterUrl,
          height: 180.0,
        ),
        SizedBox(width: 16.0),
        Expanded(child: _buildMovieInformation(theme)),
      ],
    );
  }

  Widget _buildMovieInformation(ThemeData theme) {
    var textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _movie.title,
          style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        MovieRating(_movie),
        SizedBox(height: 12.0),
        _buildCategoryChips(theme),
      ],
    );
  }

  Widget _buildCategoryChips(ThemeData theme) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(50),
      child: ListView.builder(
        itemCount: _movie.genres.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                label: Text(_movie.genres[index].name),
                labelStyle: theme.textTheme.caption.copyWith(color: Colors.white),
                backgroundColor: theme.primaryColor,
                elevation: 1,
              ),
            )
      ),
    );
  }
}