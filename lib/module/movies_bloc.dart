import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movies_challenge/data/movie_repository.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/model/page.dart';
import 'package:movies_challenge/module/movie_event.dart';
import 'package:movies_challenge/module/movie_state.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  static const itemsPerPage = 20;
  final MovieRepository movieRepository;
  ConnectivityResult _connectivityStatus;
  StreamSubscription _subscription;

  List<Page<Movie>> _pages = [];
  int _currentPage = 0;

  MoviesBloc(this.movieRepository) {
    _subscribeToConnectivityChanges();
  }

  @override
  MovieState get initialState => UninitializedState();

  @override
  Stream<MovieEvent> transform(Stream<MovieEvent> events) {
    return (events as Observable<MovieEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        movieRepository.fetchUpcomingMovies(++_currentPage)
            .listen(_onPageFetch, onDone: _onDonePageFetch, onError: _onFetchError);
      } catch (e) {
        print(e);
        yield ErrorState();
      }
    }
    if (event is PageLoaded) {
      try {
        if (_pages.isNotEmpty && _pages.last.page == _currentPage) {
          _pages.removeLast();
        }
        _pages.add(event.page);
        var movies = _pages
            .map((page) => page.results)
            .expand((iterable) => iterable).toList();
        if (_isOffline())
          yield OfflineDataState(movies: movies);
        else
          yield MoviesLoadedState(movies: movies, hasReachedMax: false);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  bool _hasReachedMax(MovieState state) =>
      state is MoviesLoadedState && state.hasReachedMax;

  void _subscribeToConnectivityChanges() {
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      _updateConnectivityStatus(result);
      _subscription = Connectivity().onConnectivityChanged
          .listen(_updateConnectivityStatus);
    });
  }

  void _updateConnectivityStatus(ConnectivityResult status) {
    if (status != _connectivityStatus) {
      if (_isOffline())
        dispatch(NoInternetConnection());
      else if (_connectivityStatus != null)
        dispatch(Fetch());
    }
    _connectivityStatus = status;
  }

  bool _isOffline() => _connectivityStatus == ConnectivityResult.none;

  void _onPageFetch(Page<Movie> page) {
    dispatch(PageLoaded(page));
  }

  void _onDonePageFetch() {
    print("Finish getting some movies");
  }


  void _onFetchError(Object error) {
    print("Error loading movies $error");
  }
}
