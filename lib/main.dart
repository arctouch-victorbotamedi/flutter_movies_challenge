import 'package:flutter/material.dart';
import 'package:movies_challenge/app.dart';
import 'package:movies_challenge/module/movies_bloc.dart';

void main() {

  final moviesBloc = MoviesBloc();

  runApp(MyApp(moviesBloc));
}
