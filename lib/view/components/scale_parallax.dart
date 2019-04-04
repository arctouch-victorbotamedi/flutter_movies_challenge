import 'package:flutter/widgets.dart';

class ScaleParallax extends StatefulWidget {
  final Widget parallax;
  final Iterable<Widget> children;
  final double height;
  
  ScaleParallax({this.parallax, this.children, this.height});

  State<StatefulWidget> createState() {
    return _ScaleParallaxState();
  }
}

class _ScaleParallaxState extends State<ScaleParallax> {
  TrackingScrollController _scrollController = TrackingScrollController();

  var _currentTopPosition = 0.0;
  var _scaledParallaxHeight = 0.0;
  
  @override
  void initState() {
    _scaledParallaxHeight = widget.height;
    _scrollController.addListener(() {
      setState(() {
        var offset = _scrollController.offset - _scrollController.initialScrollOffset;
        var factor = offset / 2;
        _currentTopPosition -= factor;
        _scaledParallaxHeight -= factor;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top : _currentTopPosition <= 0 ? _currentTopPosition : 0,
            height: widget.height >= _scaledParallaxHeight ?
              widget.height : _scaledParallaxHeight,
            child: widget.parallax
        ),
        ListView(
          physics: AlwaysScrollableScrollPhysics(parent:BouncingScrollPhysics()),
          controller: _scrollController,
          children: widget.children,
        )
      ],
    );
  }
}
