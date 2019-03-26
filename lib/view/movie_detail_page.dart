import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/view/components/movie_detail_header.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';


class MovieDetailPage extends StatelessWidget {
  final Movie _movie;

  MovieDetailPage(this._movie);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_movie.title),
        ),
        body: new ListView(
          children: [
            MovieDetailHeader(_movie),
            _overviewSection(theme)
          ],
        )
    );
  }

  Widget _overviewSection(ThemeData theme) {
    return Container(
        padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview', style: theme.textTheme.subhead.copyWith(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              _movie.overview,
              style: theme.textTheme.body1.copyWith(
                  color: Colors.black45, fontSize: 16
              ),
            )
          ],
        )
    );
  }
}
