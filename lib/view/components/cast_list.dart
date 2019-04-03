import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_challenge/common/resources.dart';
import 'package:movies_challenge/model/actor.dart';
import 'package:movies_challenge/module/movie_details_bloc.dart';
import 'package:movies_challenge/module/movie_details_state.dart';

class CastList extends StatelessWidget {
  final MovieDetailsBloc _movieDetailsBloc;

  CastList(this._movieDetailsBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _movieDetailsBloc,
      builder: (context, state) {
        return _buildCastContainer(context, state);
      },
    );
  }

  Widget _buildCastContainer(BuildContext context, MovieDetailsState state) {
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
        _buildActorList(state),
      ],
    );
  }

  Widget _buildActorList(MovieDetailsState state) {
    if (!(state is MovieCastLoadedState))
      return SizedBox(height: 5);

    MovieCastLoadedState castLoadedState = state;
    if (castLoadedState.cast.isEmpty)
      return Center(
        child: Text("No cast information provided"),
      );

    return SizedBox.fromSize(
      size: const Size.fromHeight(120.0),
      child: ListView.builder(
        itemCount: castLoadedState.cast.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 12.0, left: 20.0),
        itemBuilder: (context, index) =>
            _buildActor(context, index, castLoadedState.cast),
      ),
    );
  }

  Widget _buildActor(BuildContext ctx, int index, List<Actor> cast) {
    var actor = cast[index];
    var size = 70.0;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
           ClipOval(
              child: new CachedNetworkImage(
                placeholder: (context, url) => Image.asset(Resources.PosterPlaceholder, fit: BoxFit.cover, width: size, height: size),
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