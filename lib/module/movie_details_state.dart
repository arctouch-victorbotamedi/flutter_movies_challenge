import 'package:equatable/equatable.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';


abstract class MovieDetailsState extends Equatable {
  final Movie movie;
  MovieDetailsState(this.movie, [List props = const []])
      : super(props);
}

class BasicDetailsState extends MovieDetailsState {
  BasicDetailsState(Movie movie) : super(movie);

  @override
  String toString() => 'DetailsUninitializedState';
}

class MovieCastLoadedState extends MovieDetailsState {
  final List<Actor> cast;

  MovieCastLoadedState(Movie movie, this.cast)
      : super(movie, [cast]);

  @override
  String toString() =>
      'MovieCastLoaded { cast: ${cast.length} }';
}
