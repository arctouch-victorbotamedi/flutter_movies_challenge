import 'package:movies_challenge/model/genre.dart';

class TmdbGenre implements Genre {
  @override
  int id;
  @override
  String name;

  TmdbGenre();

  factory TmdbGenre.fromJson(Map<String, dynamic> json) =>
    TmdbGenre()
      ..id = json['id'] as int
      ..name = json['name'] as String;
}
