import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedParticles extends StatefulWidget {
  final bool isDark;
  final int particleCount;

  const AnimatedParticles({
    super.key,
    required this.isDark,
    this.particleCount = 30,
  });

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with TickerProviderStateMixin {
  late List<_Particle> particles;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
    _animationController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  void _initializeParticles() {
    particles = List.generate(widget.particleCount, (index) {
      return _Particle(
        id: index,
        startX: math.Random().nextDouble(),
        startY: math.Random().nextDouble(),
        size: 4 + math.Random().nextDouble() * 8,
        duration: 12 + math.Random().nextDouble() * 6,
        delay: math.Random().nextDouble() * 5,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: particles.map((particle) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final progress =
                (_animationController.value * 20 - particle.delay) /
                    particle.duration;
            final normalizedProgress = progress % 1.0;

            return Positioned(
              left: MediaQuery.of(context).size.width * particle.startX,
              top: MediaQuery.of(context).size.height *
                  (particle.startY - normalizedProgress),
              child: Opacity(
                opacity: widget.isDark ? 0.35 : 0.25,
                child: Container(
                  width: particle.size,
                  height: particle.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: widget.isDark
                          ? [
                              Color(0xFFF9A8D4), // Light pink
                              Color(0xFFE9D5FF), // Light purple
                            ]
                          : [
                              Color(0xFFBE185D), // Dark pink
                              Color(0xFF7C3AED), // Purple
                            ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.isDark
                            ? Color(0xFFF9A8D4).withOpacity(0.3)
                            : Color(0xFFBE185D).withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _Particle {
  final int id;
  final double startX;
  final double startY;
  final double size;
  final double duration;
  final double delay;

  _Particle({
    required this.id,
    required this.startX,
    required this.startY,
    required this.size,
    required this.duration,
    required this.delay,
  });
}
