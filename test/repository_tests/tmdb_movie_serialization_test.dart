import 'package:movies_challenge/tmdb/model/movie.dart';
import 'package:test/test.dart';

void main() {
  test('Serialization with empty genre ids', () {
    var json = {
      'id': 594451,
      'title': 'Snaggletooth',
      'original_title': 'Snaggletooth',
      'overview': 'An unusual girl needs to get her teeth fixed at midnight.',
      'release_date': '2019-04-13T00:00:00.000',
      'backdrop_path': null,
      'poster_path': '/3cijJVrz5L6a3egaKwFLr2PZb8B.jpg',
      'vote_average': 0.0,
      'genre_ids': []
    };

    var model = TmdbMovie.fromJson(json);
    expect(model.title, json['title']);
    expect(model.originalTitle, json['original_title']);
    expect(model.overview, json['overview']);
    expect(model.releaseDate.toIso8601String(), json['release_date']);
    expect(model.genreIds.isEmpty, true);

    var outputJson = model.toJson();
    expect(outputJson, json);
  });
}
