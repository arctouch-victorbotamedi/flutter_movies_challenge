import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/tmdb/api_constants.dart';

class TmdbActor implements Actor {
  @override
  int id;

  @override
  String name;

  @override
  String profileImage ;

  TmdbActor();

  factory TmdbActor.fromJson(Map<String, dynamic> json) =>
      TmdbActor()
        ..id = json['id'] as int
        ..name = json['name'] as String
        ..profileImage = _parseImageUrl(json['profile_path'] as String);

  static String _parseImageUrl(String url) {
    if (null == url)
      return "";
    return "$ImagesBaseUri/t/p/w500/$url";
  }
}