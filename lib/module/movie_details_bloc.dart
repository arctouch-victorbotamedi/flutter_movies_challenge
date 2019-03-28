import 'package:bloc/bloc.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/module/movie_details_state.dart';
import 'package:movies_challenge/module/movie_event.dart';

class MovieDetailsBloc extends Bloc<MovieEvent, MovieDetailsState> {
  final Movie _movie;
  final MovieRepository _movieRepository;

  MovieDetailsBloc(this._movie, this._movieRepository);

  @override
  get initialState => BasicDetailsState(_movie);

  @override
  Stream<MovieDetailsState> mapEventToState(event) async* {
    if (event is Fetch) {
      var cast = await _movieRepository.fetchCast(_movie);
      yield MovieCastLoadedState(_movie, cast);
    }
  }
}