import 'package:flutter/material.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/home_page.dart';
import 'package:movies_challenge/view/providers/movies_provider.dart';


class MyApp extends StatelessWidget {

  final MoviesBloc moviesBloc;
  final MovieRepository movieRepository;

  MyApp(this.movieRepository, this.moviesBloc) {
    moviesBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      movieRepository: movieRepository,
      moviesBloc: moviesBloc,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}
