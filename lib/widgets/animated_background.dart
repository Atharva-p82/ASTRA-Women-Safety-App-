import 'package:flutter/material.dart';
import 'animated_particles.dart';
import 'floating_shields.dart';
// import 'sky_decorations.dart';

class AnimatedBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Color(0xFF131313), // Deep dark
                      Color(0xFF202034), // Blue-black
                      Color(0xFF1A1A2E), // Darker blue
                    ]
                  : [
                      Color(0xFFFFF9FA), // Ultra-light blush
                      Color(0xFFFFF5FA), // Light blush
                      Color(0xFFFFF9FA), // Ultra-light blush
                    ],
            ),
          ),
        ),

        // Animated particles
        AnimatedParticles(
          isDark: isDark,
          particleCount: 30,
        ),

        // Floating shields
        FloatingShields(
          isDark: isDark,
          shieldCount: 8,
        ),

        // Sky Decorations (Sun/Moon + Clouds) - STATIC ON TOP
        // SkyDecorations(isDark: isDark),

        // Child widget on top (but behind sky decorations in terms of z-order)
        child,
      ],
    );
  }
}
