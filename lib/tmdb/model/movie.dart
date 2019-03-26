import 'package:movies_challenge/model/genre.dart';
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
  @override
  List<Genre> genres;
  @override
  double rating;

  List<int> _genreIds;

  TmdbMovie(this.title);

  void _setGenres(List<Genre> allGenres) {
    genres = allGenres
        .where((genre) => _genreIds.any((id) => id == genre.id))
        .toList();
  }

  factory TmdbMovie.fromJson(Map<String, dynamic> json, List<Genre> allGenres) =>
      new TmdbMovie(json['title'] as String)
        ..id = json['id'] as int
        ..originalTitle = json['original_title'] as String
        ..overview = json['overview'] as String
        ..releaseDate = json['release_date'] == null
            ? null
            : DateTime.parse(json['release_date'] as String)
        ..backdropUrl = _parsePhotoUrl(json['backdrop_path'] as String)
        ..posterUrl = _parsePhotoUrl(json['poster_path'] as String)
        ..rating = json['vote_average'].toDouble()
        .._genreIds = (json['genre_ids'] as List)
            ?.map((e) => e as int)?.toList()
        .._setGenres(allGenres);

  static String _parsePhotoUrl(String url) {
    if (null == url)
      return "";
    return "$ImagesBaseUri/t/p/w500/$url";
  }
}
