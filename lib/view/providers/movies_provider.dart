
import 'package:flutter/widgets.dart';
import 'package:movies_challenge/module/movies_bloc.dart';

class MoviesProvider extends InheritedWidget {
  final MoviesBloc moviesBloc;

  MoviesProvider({Key key, @required MoviesBloc movies, Widget child})
      : assert(movies != null),
        moviesBloc = movies,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MoviesBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MoviesProvider) as MoviesProvider)
          .moviesBloc;
}