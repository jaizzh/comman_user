import 'package:flutter/material.dart';

Future<T?> navigateWithSlide<T>(
  BuildContext context,
  Widget page, {
  Offset begin = const Offset(1.0, 0.0), // Default: right to left
  Curve curve = Curves.ease,
}) {
  return Navigator.push<T>(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: Offset.zero)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
