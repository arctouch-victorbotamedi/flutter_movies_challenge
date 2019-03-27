import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_challenge/common/resources.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/model/movie.dart';
import 'package:movies_challenge/view/providers/movies_provider.dart';

class CastList extends StatelessWidget {
  final Movie _movie;
  List<Actor> _cast;

  CastList(this._movie);

  @override
  Widget build(BuildContext context) {
    final moviesBloc = MoviesProvider.of(context);
    return Text("Refactoring....");
    //return FutureBuilder<List<Actor>>(
    //  future: moviesBloc.cast(_movie),
    //  builder: _buildCastContainer,
    //);
  }

  Widget _buildCastContainer(BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
    _cast = snapshot.data;
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0),
          child: Text(
            'Cast',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        _buildActorList(snapshot),
      ],
    );
  }

  Widget _buildActorList(AsyncSnapshot<List<Actor>> snapshot) {
    if (snapshot.connectionState != ConnectionState.done)
      return SizedBox(height: 5);
    if (snapshot.hasError || _cast.isEmpty)
      return Center(
        child: Text("No cast information provided"),
      );

    return SizedBox.fromSize(
      size: const Size.fromHeight(120.0),
      child: ListView.builder(
        itemCount: _cast.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 12.0, left: 20.0),
        itemBuilder: _buildActor,
      ),
    );
  }

  Widget _buildActor(BuildContext ctx, int index) {
    var actor = _cast[index];
    var size = 70.0;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
           ClipOval(
              child: new CachedNetworkImage(
                placeholder: (context, url) => Image.asset(Resources.PosterPlaceholder, width: size, height: size),
                imageUrl: actor.profileImage,
                fit: BoxFit.cover,
                width: size,
                height: size,
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(actor.name),
          ),
        ],
      ),
    );
  }
}