import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingShields extends StatefulWidget {
  final bool isDark;
  final int shieldCount;

  const FloatingShields({
    super.key,
    required this.isDark,
    this.shieldCount = 8,
  });

  @override
  State<FloatingShields> createState() => _FloatingShieldsState();
}

class _FloatingShieldsState extends State<FloatingShields>
    with TickerProviderStateMixin {
  late List<_ShieldData> shields;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeShields();
    _animationController = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  void _initializeShields() {
    shields = List.generate(widget.shieldCount, (index) {
      return _ShieldData(
        id: index,
        startX: math.Random().nextDouble() * 100,
        startY: math.Random().nextDouble() * 100,
        duration: 10 + math.Random().nextDouble() * 5,
        delay: index * 1.5,
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
      children: shields.map((shield) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final delayedProgress =
                (_animationController.value * 30 - shield.delay) /
                    shield.duration;
            final normalizedProgress = delayedProgress % 1.0;

            // Calculate movement (sine wave for smooth oscillation)
            final offsetX =
                math.sin(normalizedProgress * math.pi * 2) * 30;
            final offsetY =
                math.cos(normalizedProgress * math.pi * 2) * 50;
            final rotation = normalizedProgress * math.pi * 2;

            return Positioned(
              left: MediaQuery.of(context).size.width * shield.startX / 100,
              top: MediaQuery.of(context).size.height * shield.startY / 100,
              child: Transform.translate(
                offset: Offset(offsetX, offsetY),
                child: Transform.rotate(
                  angle: rotation,
                  child: Opacity(
                    opacity: widget.isDark ? 0.25 : 0.15,
                    child: Icon(
                      Icons.security,
                      size: 64,
                      color: widget.isDark
                          ? Color(0xFFFF69B4) // Hot pink
                          : Color(0xFFA855F7), // Purple
                    ),
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

class _ShieldData {
  final int id;
  final double startX;
  final double startY;
  final double duration;
  final double delay;

  _ShieldData({
    required this.id,
    required this.startX,
    required this.startY,
    required this.duration,
    required this.delay,
  });
}

