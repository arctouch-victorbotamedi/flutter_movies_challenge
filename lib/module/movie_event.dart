import 'package:equatable/equatable.dart';


abstract class MovieEvent extends Equatable {}

class Fetch extends MovieEvent {
  @override
  String toString() => 'Fetch';
}

class NoInternetConnection extends MovieEvent {
  @override
  String toString() => 'NoInternetConnection';
}
