import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/view/movie_detail_page.dart';
import 'package:movies_challenge/view/components/poster_hero.dart';

class MovieListItem extends StatelessWidget {
  final Movie _movie;
  final tmdbImagesBaseUri = "http://image.tmdb.org/";
  final _biggerFont = const TextStyle(fontSize: 18.0);

  MovieListItem(this._movie);

  @override
  Widget build(BuildContext context) {
    return new InkResponse(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new MovieDetailPage(_movie)));
        },
        highlightShape: BoxShape.rectangle,
        child: new Container(
          child: new Row(
            children: [
              new PosterHero(
                tag: _movie.id.toString(),
                image: _movie.posterUrl,
                height: 100.0,
              ),
              new Expanded(
                  child: new Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                        _movie.title,
                        style: _biggerFont,
                        overflow: TextOverflow.fade),
                  ))
            ],
          ),
        ));
  }
}
