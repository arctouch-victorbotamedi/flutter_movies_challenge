import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/common/resources.dart';


class Poster extends StatelessWidget {

  static const PosterRatio = 0.7;

  final String url;
  final double height;

  Poster(
      this.url, {
        this.height = 100.0,
      });

  @override
  Widget build(BuildContext context) {
    var width = PosterRatio * height;

    return new Material(
      borderRadius: new BorderRadius.circular(3.0),
      elevation: 2.0,
      child: new CachedNetworkImage(
          placeholder: (context, url) => Image.asset(Resources.PosterPlaceholder, width: width, height: height),
          imageUrl: url,
          fit: BoxFit.cover,
          width: width,
          height: height,
      )
    );
  }
}
