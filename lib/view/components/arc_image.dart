import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_challenge/common/resources.dart';


class ArcImage extends StatelessWidget {
  ArcImage(this._imageUrl, this._height);

  final String _imageUrl;
  final double _height;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: ArcClipper(),
      child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 232, 232, 232)),
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(
                Resources.BackdropPlaceholder, width: screenWidth, height: _height),
            imageUrl: _imageUrl,
            fit: BoxFit.cover,
            width: screenWidth,
            height: _height,
          ),
      )
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}