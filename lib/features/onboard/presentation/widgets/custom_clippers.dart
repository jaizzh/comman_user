import 'package:flutter/material.dart';

class BigClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 696;

    path.lineTo(-0.004 * xScaling, 341.785 * yScaling);
    path.cubicTo(
      -0.004 * xScaling,
      341.785 * yScaling,
      23.461 * xScaling,
      363.151 * yScaling,
      71.553 * xScaling,
      363.151 * yScaling,
    );
    path.cubicTo(
      119.645 * xScaling,
      363.151 * yScaling,
      142.217 * xScaling,
      300.186 * yScaling,
      203.295 * xScaling,
      307.21 * yScaling,
    );
    path.cubicTo(
      264.373 * xScaling,
      314.234 * yScaling,
      282.666 * xScaling,
      333.473 * yScaling,
      338.408 * xScaling,
      333.473 * yScaling,
    );
    path.cubicTo(
      394.15 * xScaling,
      333.473 * yScaling,
      413.996 * xScaling,
      254.199 * yScaling,
      413.996 * xScaling,
      254.199 * yScaling,
    );
    path.cubicTo(
      413.996 * xScaling,
      254.199 * yScaling,
      413.996 * xScaling,
      0 * yScaling,
      413.996 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      413.996 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      -0.004 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      341.785 * yScaling,
      -0.004 * xScaling,
      341.785 * yScaling,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Fixed: Return false instead of throwing error
  }
}

class SmallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 596;

    path.lineTo(-0.004 * xScaling, 217.841 * yScaling);
    path.cubicTo(
      -0.004 * xScaling,
      217.841 * yScaling,
      19.14 * xScaling,
      265.92 * yScaling,
      67.233 * xScaling,
      265.92 * yScaling,
    );
    path.cubicTo(
      115.326 * xScaling,
      265.92 * yScaling,
      112.752 * xScaling,
      234.611 * yScaling,
      173.833 * xScaling,
      241.635 * yScaling,
    );
    path.cubicTo(
      234.914 * xScaling,
      248.659 * yScaling,
      272.866 * xScaling,
      301.691 * yScaling,
      328.608 * xScaling,
      301.691 * yScaling,
    );
    path.cubicTo(
      384.35 * xScaling,
      301.691 * yScaling,
      413.996 * xScaling,
      201.977 * yScaling,
      413.996 * xScaling,
      201.977 * yScaling,
    );
    path.cubicTo(
      413.996 * xScaling,
      201.977 * yScaling,
      413.996 * xScaling,
      0 * yScaling,
      413.996 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      413.996 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      -0.004 * xScaling,
      0 * yScaling,
      -0.004 * xScaling,
      217.841 * yScaling,
      -0.004 * xScaling,
      217.841 * yScaling,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Fixed: Return false instead of throwing error
  }
}
