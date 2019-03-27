import 'package:flutter/material.dart';
import 'package:movies_challenge/app.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_repository.dart';

void main() {

  final moviesBloc = MoviesBloc(TmdbMovieRepository());

  runApp(MyApp(moviesBloc));
}
