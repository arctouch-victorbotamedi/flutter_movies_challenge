import 'package:equatable/equatable.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/model/page.dart';


abstract class MovieEvent extends Equatable {}

class Fetch extends MovieEvent {
  @override
  String toString() => 'Fetch';
}

class NoInternetConnection extends MovieEvent {
  @override
  String toString() => 'NoInternetConnection';
}

class PageLoaded extends MovieEvent {
  final Page<Movie> page;

  PageLoaded(this.page);

  @override
  String toString() => 'PageLoaded: ${page.page}';
}
