import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShellParticleAnimation extends StatefulWidget {
  final Widget child;
  final bool isDark;

  const ShellParticleAnimation({
    super.key,
    required this.child,
    this.isDark = false,
  });

  @override
  State<ShellParticleAnimation> createState() => _ShellParticleAnimationState();
}

class _ShellParticleAnimationState extends State<ShellParticleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..repeat();

    // Create particles
    for (int i = 0; i < 10; i++) {
      particles.add(
        Particle(
          x: math.Random().nextDouble(),
          y: math.Random().nextDouble(),
          size: math.Random().nextDouble() * 30 + 10,
          speed: math.Random().nextDouble() * 0.5 + 0.2,
          opacity: math.Random().nextDouble() * 0.5 + 0.2,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: particles,
            progress: _controller.value,
            isDark: widget.isDark,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  final bool isDark;

  ParticlePainter({
    required this.particles,
    required this.progress,
    this.isDark = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      double newY = (particle.y + progress * particle.speed) % 1.0;
      
      final paint = Paint()
        ..color = (isDark ? Colors.pink.shade300 : Colors.pink.shade200)
            .withOpacity(particle.opacity * (1 - (newY - particle.y).abs()));

      canvas.drawOval(
        Rect.fromCircle(
          center: Offset(particle.x * size.width, newY * size.height),
          radius: particle.size / 2,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
