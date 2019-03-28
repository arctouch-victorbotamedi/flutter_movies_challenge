
import 'package:flutter/widgets.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/module/movie_details_bloc.dart';
import 'package:movies_challenge/module/movies_bloc.dart';

class DependencyProvider extends InheritedWidget {
  final MoviesBloc moviesBloc;
  final MovieRepository movieRepository;

  DependencyProvider({
    Key key,
    @required MovieRepository movieRepository,
    @required MoviesBloc moviesBloc,
    Widget child})
      : assert(movieRepository != null),
        movieRepository = movieRepository,
        moviesBloc = moviesBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MoviesBloc moviesBlocOf(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DependencyProvider) as DependencyProvider)
          .moviesBloc;

  static MovieRepository movieRepositoryOf(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DependencyProvider) as DependencyProvider)
          .movieRepository;
}
