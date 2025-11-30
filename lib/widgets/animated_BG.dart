import 'package:flutter/material.dart';
import 'animated_particles.dart';
import 'twinkling_stars.dart';
import 'cloud_outlines.dart';

class AnimatedBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;
  final int cloudCount;
  final double cloudSpeed;
  final int starCount;
  final double starTwinkleSpeed;

  const AnimatedBackground({
    super.key,
    required this.isDark,
    required this.child,
    this.cloudCount = 16,
    this.cloudSpeed = 1.7,
    this.starCount = 50,
    this.starTwinkleSpeed = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [Color(0xFF131313), Color(0xFF202034), Color(0xFF1A1A2E)]
                  : [Color(0xFFFFF9FA), Color(0xFFFFF5FA), Color(0xFFFFF9FA)],
            ),
          ),
        ),
        if (!isDark)
          CloudOutlines(
            isDark: false,
            cloudCount: cloudCount,
            cloudSpeed: cloudSpeed,
          ),
        if (isDark)
          TwinklingStars(
            isDark: true,
            starCount: starCount,
            twinkleSpeed: starTwinkleSpeed,
          ),
        AnimatedParticles(isDark: isDark, particleCount: 30),
        child,
      ],
    );
  }
}
