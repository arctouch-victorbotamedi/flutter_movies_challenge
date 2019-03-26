
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';

class MovieRating extends StatelessWidget {
  MovieRating(this._movie);
  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildNumericRating(theme, ratingCaptionStyle),
        SizedBox(width: 16.0),
        _buildStarRating(theme, ratingCaptionStyle),
      ],
    );
  }

  Widget _buildNumericRating(ThemeData theme, TextStyle ratingCaptionStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _movie.rating.toString(),
          style: theme.textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Ratings',
          style: ratingCaptionStyle,
        ),
      ],
    );
  }

  Widget _buildStarRating(ThemeData theme, TextStyle ratingCaptionStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingBar(theme),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            'Grade now',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];

    var fiveStarRating = _movie.rating / 2;
    for (var i = 1; i <= 5; i++) {
      var color = i <= fiveStarRating ? theme.accentColor : Colors.black12;
      var star = Icon(
        Icons.star,
        color: color,
      );
      stars.add(star);
    }
    return Row(children: stars);
  }
}
