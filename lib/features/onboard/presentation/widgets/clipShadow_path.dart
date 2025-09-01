import 'package:flutter/cupertino.dart';

class ClipShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final BoxShadow shadow;

  ClipShadowPainter({
    required this.clipper,
    required this.shadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = shadow.color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);

    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
