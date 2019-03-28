import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/app.dart';
import 'package:movies_challenge/module/bloc_log_delegate.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_repository.dart';

void main() {
  final repository = TmdbMovieRepository();
  final moviesBloc = MoviesBloc(repository);
  BlocSupervisor().delegate = BlocLogDelegate();
  runApp(MyApp(repository, moviesBloc));
}
