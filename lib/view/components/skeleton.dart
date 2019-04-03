import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final bool isLoaded;
  final double width;
  final double height;
  final Widget Function(BuildContext context) itemBuilder;

  Skeleton({this.itemBuilder, this.isLoaded, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (isLoaded)
      return itemBuilder(context);
    return Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 220, 220, 220),
          highlightColor: Color.fromARGB(255, 240, 240, 240),
          child: Container(
              decoration: BoxDecoration(color: Colors.white)
          ),
        ),
      ),
    );
  }
}
