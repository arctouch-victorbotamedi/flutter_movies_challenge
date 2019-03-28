import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movie_details_bloc.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/view/components/cast_list.dart';
import 'package:movies_challenge/view/components/movie_detail_header.dart';


class MovieDetailPage extends StatelessWidget {
  final MovieDetailsBloc _movieDetailsBloc;

  MovieDetailPage(this._movieDetailsBloc) {
    _movieDetailsBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_movieDetailsBloc.currentState.movie.title),
        ),
        body: new ListView(
          children: [
            MovieDetailHeader(_movieDetailsBloc.currentState.movie),
            _overviewSection(theme),
            CastList(_movieDetailsBloc)
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
              _movieDetailsBloc.currentState.movie.overview,
              style: theme.textTheme.body1.copyWith(
                  color: Colors.black45, fontSize: 16
              ),
            )
          ],
        )
    );
  }
}
