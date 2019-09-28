import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageClippingApp extends StatefulWidget {
  @override
  _ImageClippingAppState createState() => _ImageClippingAppState();
}

class _ImageClippingAppState extends State<ImageClippingApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDribblePage(),
    );
  }

  Widget _buildDribblePage() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Flexible(
            child: ClipPath(
              child: Image.asset("assets/image_02.jpg"),
              clipper: BottomWaveClipper(),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Flexible(
            child: ClipPath(
              child: Image.asset("assets/image_03.jpg"),
              clipper: BottomWaveLineClipper(),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Flexible(
            child: ClipPath(
              child: Image.asset("assets/image_04.jpg"),
              clipper: BottomWaveCurveClipper(),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    /*// Draw a straight line from current point to the bottom left corner.
    path.lineTo(0.0, size.height);

    // Draw a straight line from current point to the top right corner.
    path.lineTo(size.width, 0.0);

    // Draws a straight line from current point to the first point of the path.
    // In this case (0, 0), since that's where the paths start by default.
    path.close();*/

    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomWaveLineClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomWaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
