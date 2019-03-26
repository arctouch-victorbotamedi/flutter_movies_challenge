

import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/tmdb/model/actor.dart';

class Credits {
  int id;
  List<Actor> cast;

  Credits();

  factory Credits.fromJson(Map<String, dynamic> json) =>
      Credits()
        ..id = json['id'] as int
        ..cast = (json['cast'] as List)
            ?.map((e) => e == null ? null : TmdbActor.fromJson(e as Map<String, dynamic>))
            ?.toList();
}