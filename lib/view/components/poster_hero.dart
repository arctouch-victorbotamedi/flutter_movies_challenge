import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_challenge/view/components/poster.dart';


class PosterHero extends StatelessWidget {
  const PosterHero({ Key key, this.tag, this.image, this.onTap, this.height })
      : super(key: key);

  final String tag;
  final String image;
  final VoidCallback onTap;
  final double height;

  Widget build(BuildContext context) {
    return new Hero(
      tag: tag,
      child: new Poster(image, height: height),
    );
  }
}
