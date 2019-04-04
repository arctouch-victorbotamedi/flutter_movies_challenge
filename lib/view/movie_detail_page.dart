import 'package:flutter/material.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movie_details_bloc.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/view/components/arc_image.dart';
import 'package:movies_challenge/view/components/cast_list.dart';
import 'package:movies_challenge/view/components/movie_detail_header.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


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

  var top = 0.0;
  var imageHeight = 230.0;
  var scaledImageHeight = 230.0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
        appBar: GradientAppBar(
          backgroundColorStart: theme.primaryColor,
          backgroundColorEnd: theme.accentColor,
          title: new Text(_movie.title),
        ),
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            setState(() {
              var factor = notification.scrollDelta / 2;
              top -= factor;
              scaledImageHeight -= factor;
              print('Scale: $scaledImageHeight');
              print('Top: $top');
            });
          },
          child: Stack(
            children: [
              Positioned(
                top : top <= 0 ? top : 0,
                child: ArcImage(_movie.backdropUrl, imageHeight >= scaledImageHeight ? imageHeight : scaledImageHeight)
              ),
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 200.0),
                    child: MovieDetailHeader(_movie),
                  ),
                  _overviewSection(theme),
                  CastList(_movieDetailsBloc)
                ],
              )
            ],
          )
        )
    );
  }

  Widget _overviewSection(ThemeData theme) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 15.0),
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
