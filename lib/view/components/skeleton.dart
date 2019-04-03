import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final bool isLoaded;
  final double width;
  final double height;
  final Widget Function(BuildContext context) itemBuilder;
  final Duration duration;

  Skeleton({
    this.itemBuilder,
    this.isLoaded,
    this.width,
    this.height,
    this.duration: const Duration(milliseconds: 2000)});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: duration,
        child: isLoaded ? itemBuilder(context) : _buildSkeleton(),
        layoutBuilder: (currentChild, previousChildren) => currentChild
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Shimmer.fromColors(
        baseColor: Color.fromARGB(255, 220, 220, 220),
        highlightColor: Color.fromARGB(255, 240, 240, 240),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2)
            )
        ),
      )
    );
  }
}
