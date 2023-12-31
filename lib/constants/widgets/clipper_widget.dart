import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from the top-right corner
    path.moveTo(size.width, 0);

    // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Draw a quadratic bezier curve to the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, 0, 0);

    // Draw a line to the top-left corner
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipPathContainer extends StatelessWidget {
  const ClipPathContainer({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(height: h * 0.28, width: w, color: Color(0xFF004AAD)),
    );
  }
}
