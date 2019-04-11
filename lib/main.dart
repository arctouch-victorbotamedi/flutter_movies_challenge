import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/app.dart';
import 'package:movies_challenge/data/cache/cache_database_provider.dart';
import 'package:movies_challenge/module/bloc_log_delegate.dart';
import 'package:movies_challenge/module/movies_bloc.dart';
import 'package:movies_challenge/module/search_bloc.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_api.dart';
import 'package:movies_challenge/tmdb/repository/tmdb_movie_repository.dart';

void main() {
  final repository = TmdbMovieRepository(TmdbMovieApi(), CacheDatabaseProvider.instance);
  final moviesBloc = MoviesBloc(repository);
  final searchBloc = SearchBloc(repository);
  BlocSupervisor().delegate = BlocLogDelegate();
  runApp(MyApp(repository, moviesBloc, searchBloc));
}
