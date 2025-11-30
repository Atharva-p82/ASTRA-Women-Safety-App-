import 'package:flutter/material.dart';
import 'dart:math' as math;

class TwinklingStars extends StatefulWidget {
  final int starCount;
  final double twinkleSpeed;
  final bool isDark;

  const TwinklingStars({
    super.key,
    required this.isDark,
    this.starCount = 48,
    this.twinkleSpeed = 1.0,
  });

  @override
  State<TwinklingStars> createState() => _TwinklingStarsState();
}

class _TwinklingStarsState extends State<TwinklingStars> with TickerProviderStateMixin {
  late List<_StarData> stars;
  late List<AnimationController> controllers;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    stars = List.generate(widget.starCount, (i) {
      return _StarData(
        left: random.nextDouble(),
        top: random.nextDouble(),
        size: 1.4 + random.nextDouble() * 2.2,
        period: 0.88 + random.nextDouble() * (2.2 / widget.twinkleSpeed),
        initial: random.nextDouble(),
        phase: random.nextDouble() * 2 * math.pi,
      );
    });
    controllers = stars.map((star) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (star.period * 1000 / widget.twinkleSpeed).toInt()),
      )..forward(from: star.initial);
    }).toList();
    for (var c in controllers) {
      c.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDark) return const SizedBox.shrink();
    return Stack(
      children: List.generate(stars.length, (i) {
        final star = stars[i];
        return AnimatedBuilder(
          animation: controllers[i],
          builder: (context, child) {
            // Randomize each star's twinkle phase for natural effect
            double base = math.sin(controllers[i].value * 2 * math.pi + star.phase);
            double twinkle = 0.60 + 0.35 * base;
            return Positioned(
              left: MediaQuery.of(context).size.width * star.left,
              top: MediaQuery.of(context).size.height * star.top,
              child: Opacity(
                opacity: twinkle,
                child: Container(
                  width: star.size,
                  height: star.size,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _StarData {
  final double left, top, size, period, initial, phase;

  _StarData({
    required this.left,
    required this.top,
    required this.size,
    required this.period,
    required this.initial,
    required this.phase,
  });
}
