import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/view/home_page.dart';

class MyApp extends StatelessWidget {

  final MoviesBloc moviesBloc;
  final MovieRepository movieRepository;

  MyApp(this.movieRepository, this.moviesBloc) {
    moviesBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      bloc: moviesBloc,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primaryColor: Color.fromARGB(255, 219, 48, 100),
          accentColor: Color.fromARGB(255, 249, 159, 0),
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          scaffoldBackgroundColor: Color.fromARGB(255, 248, 248, 248),
        ),
        home: new HomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}
