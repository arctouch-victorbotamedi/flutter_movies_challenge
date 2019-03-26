

import 'package:movies_challenge/model/genre.dart';

abstract class Movie {
  int get id;
  String get title;
  String get originalTitle;
  String get overview;
  DateTime get releaseDate;
  String get backdropUrl;
  String get posterUrl;
  List<Genre> get genres;
}
