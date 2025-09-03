import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium circular progress with center content (title, % value, subtitle)
class PremiumCircularProgress extends StatelessWidget {
  const PremiumCircularProgress({
    super.key,
    required this.value,              // 0.0 to 1.0
    this.size = 160,
    this.title = 'Progress',
    this.subtitle = 'Completed',
    this.startColor = const Color(0xFF9A2143), // your brand: buttoncolor
  //  this.endColor   = const Color(0xFFBFA054), // your brand: boxdarkcolor
    this.trackColor = const Color(0xFFF3ECE3), // your brand: boxboxlight (#F3ECE3)
    this.innerBg    = const Color(0xFFFFFFFF),
    this.duration   = const Duration(milliseconds: 1200),
  });

  final double value;
  final double size;
  final String title;
  final String subtitle;
  final Color startColor;
//  final Color endColor;
  final Color trackColor;
  final Color innerBg;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final stroke = size * 0.10; // thickness proportional to size

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        final percent = (v * 100).round();

        return SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow arc (subtle)
              CustomPaint(
                size: Size.square(size),
                painter: _RingPainter(
                  progress: v,
                  strokeWidth: stroke + 2,
                  startColor: startColor.withOpacity(0.45),
                  endColor: startColor,
                 // endColor: endColor.withOpacity(0.45),
                  trackColor: Colors.transparent,
                  glow: true,
                ),
              ),
              // Main ring (track + gradient progress)
              CustomPaint(
                size: Size.square(size),
                painter: _RingPainter(
                  progress: v,
                  strokeWidth: stroke,
                  startColor: startColor,
                  endColor: startColor,
                  trackColor: trackColor,
                  glow: false,
                ),
              ),
              // Inner glassy disc with content
              Container(
                height: size - stroke * 1.6,
                width: size - stroke * 1.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      innerBg.withOpacity(0.96),
                      innerBg.withOpacity(0.88),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF5A5560),
                            fontWeight: FontWeight.w600,
                            letterSpacing: .2,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$percent%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.0,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF7A7780),
                            letterSpacing: .3,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.startColor,
    required this.endColor,
    required this.trackColor,
    required this.glow,
  });

  final double progress; // 0..1
  final double strokeWidth;
  final Color startColor;
  final Color endColor;
  final Color trackColor;
  final bool glow;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2 - strokeWidth / 2;
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * math.pi,
      false,
      trackPaint,
    );

    // Gradient progress paint
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 1.5 * math.pi,
      colors: [startColor, endColor],
      stops: const [0.0, 1.0],
      transform: const GradientRotation(0),
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius + strokeWidth))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (glow) {
      final glowPaint = Paint()
        ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius + strokeWidth))
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        glowPaint,
      );
    }

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.startColor != startColor ||
      oldDelegate.endColor != endColor ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.glow != glow;
}
