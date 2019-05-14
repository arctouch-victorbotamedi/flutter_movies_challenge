import 'dart:convert';

import 'package:movies_challenge/model/genre.dart';
import 'package:movies_challenge/tmdb/model/genre.dart';


class GenreCollection {

  List<Genre> results;

  GenreCollection();

  factory GenreCollection.fromJson(Map<String, dynamic> json) =>
      new GenreCollection()
        ..results = (json['genres'] as List)
            ?.map((e) => e == null ? null : TmdbGenre.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() => {
    'genres': jsonEncode(results)
  };
}
