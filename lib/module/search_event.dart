import 'package:equatable/equatable.dart';


class SearchEvent extends Equatable {
  final String movieName;

  SearchEvent(this.movieName);

  @override
  String toString() => 'Fetch';
}
