import 'package:equatable/equatable.dart';
import 'package:movies_challenge/model/movie.dart';

abstract class MovieEvent extends Equatable {}

class Fetch extends MovieEvent {
  @override
  String toString() => 'Fetch';
}

class FetchCast extends MovieEvent {
  final Movie movie;

  FetchCast(this.movie);

  @override
  String toString() => 'FetchCast';
}
