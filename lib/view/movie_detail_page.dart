import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';


class MovieDetailPage extends StatelessWidget {
  final Movie _movie;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  MovieDetailPage(this._movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_movie.title),
        ),
        body: new ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _posterSection(),
            _overviewSection()
          ],
        )
    );
  }

  Widget _posterSection() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new PosterHero(
          tag: _movie.id.toString(),
          image: _movie.posterUrl,
          height: 200.0,
        ),
        _titleSection()
      ],
    );
  }

  Widget _titleSection() {
    return
        new Flexible(
          child: new Container(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              _movie.title,
              style: _biggerFont,
              softWrap: true,
            ),
          )
        );
  }

  Widget _overviewSection() {
    return new Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Text(
          _movie.overview,
          softWrap: true,
    ));
  }
}
