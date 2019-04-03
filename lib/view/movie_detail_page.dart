import 'package:flutter/material.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movie_details_bloc.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/view/components/cast_list.dart';
import 'package:movies_challenge/view/components/movie_detail_header.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieRepository movieRepository;
  final Movie movie;

  MovieDetailPage(this.movieRepository, this.movie);
  @override
  State<StatefulWidget> createState() => _MovieDetailsPage();
}

class _MovieDetailsPage extends State<MovieDetailPage> {
  MovieDetailsBloc _movieDetailsBloc;

  MovieRepository get _movieRepository => widget.movieRepository;
  Movie get _movie => widget.movie;

  @override
  void initState() {
    _movieDetailsBloc = MovieDetailsBloc(_movie, _movieRepository);
    _movieDetailsBloc.dispatch(Fetch());
    super.initState();
  }

  @override
  void dispose() {
    _movieDetailsBloc.dispose();
    super.dispose();
  }

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
