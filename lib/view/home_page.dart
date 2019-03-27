import 'package:flutter/material.dart';
import 'package:movies_challenge/view/components/movie_list.dart';


class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Movies'),
      ),
      body: MovieList(),
    );
  }
}
