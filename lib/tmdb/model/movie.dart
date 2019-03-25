import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/tmdb/api_constants.dart';


class TmdbMovie implements Movie {

  @override
  int id;
  @override
  String title;
  @override
  String originalTitle;
  @override
  String overview;
  @override
  DateTime releaseDate;
  @override
  String backdropUrl;
  @override
  String posterUrl;

  TmdbMovie(this.title);

  factory TmdbMovie.fromJson(Map<String, dynamic> json) =>
      new TmdbMovie(json['title'] as String)
        ..id = json['id'] as int
        ..originalTitle = json['original_title'] as String
        ..overview = json['overview'] as String
        ..releaseDate = json['release_date'] == null
            ? null
            : DateTime.parse(json['release_date'] as String)
        ..backdropUrl = _parsePhotoUrl(json['backdrop_path'] as String)
        ..posterUrl = _parsePhotoUrl(json['poster_path'] as String);

  static String _parsePhotoUrl(String url) {
    return "${ImagesBaseUri}/t/p/w500/${url}";
  }
}
