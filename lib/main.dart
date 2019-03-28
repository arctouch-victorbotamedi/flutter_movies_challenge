import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/app.dart';
import 'package:movies_challenge/module/bloc_log_delegate.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_repository.dart';

void main() {

  final moviesBloc = MoviesBloc(TmdbMovieRepository());
  BlocSupervisor().delegate = BlocLogDelegate();
  runApp(MyApp(moviesBloc));
}
