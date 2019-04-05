import 'package:flutter/material.dart';
import 'package:movies_challenge/view/components/movie_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:movies_challenge/view/components/movie_search_delegate.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: theme.primaryColor,
        backgroundColorEnd: theme.accentColor,
        elevation: 1,
        bottomOpacity: 0.5,
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            }
          )
        ]
      ),
      body: MovieList(),
    );
  }
}
