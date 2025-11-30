import 'package:flutter/material.dart';

class SkyDecorations extends StatelessWidget {
  final bool isDark;

  const SkyDecorations({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 200,
      child: Stack(
        children: [
          // Light Mode: Simple Sun (circle with border) - NO CLOUDS
          if (!isDark) ...[
            // Sun (simple circle with thick border)
            Positioned(
              top: 30,
              right: 50,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: Color(0xFFE94057), // Pink (shield color)
                    width: 6,
                  ),
                ),
              ),
            ),
          ],

          // Dark Mode: Moon and Fluffy Clouds
          if (isDark) ...[
            // Moon (soft, less bright)
            Positioned(
              top: 20,
              right: 45,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFD0D0D0).withOpacity(0.6),
                      Color(0xFFC0C0C0).withOpacity(0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFDA22FF).withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Crescent shadow
                    Positioned(
                      right: -20,
                      top: 15,
                      child: Container(
                        width: 70,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF202034).withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Cloud 1 (top left - fluffy, positioned like image)
            Positioned(
              top: 60,
              left: 20,
              child: _buildFluffyCloud(
                width: 140,
                height: 70,
                opacity: 0.5,
              ),
            ),
            // Cloud 2 (bottom right - fluffy, positioned like image)
            Positioned(
              bottom: 10,
              right: 80,
              child: _buildFluffyCloud(
                width: 120,
                height: 60,
                opacity: 0.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _buildFluffyCloud({
    required double width,
    required double height,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: CustomPaint(
        size: Size(width, height),
        painter: FluffyCloudPainter(),
      ),
    );
  }
}

class FluffyCloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFC5C5C5) // Gray clouds
      ..style = PaintingStyle.fill;

    // Left cloud bump
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.65),
      size.width * 0.12,
      paint,
    );

    // Left-middle cloud bump
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.4),
      size.width * 0.16,
      paint,
    );

    // Center cloud bump (largest)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.3),
      size.width * 0.2,
      paint,
    );

    // Right-middle cloud bump
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.4),
      size.width * 0.16,
      paint,
    );

    // Right cloud bump
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.65),
      size.width * 0.12,
      paint,
    );

    // Cloud base rectangle
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.55, size.width, size.height * 0.45),
      paint,
    );
  }

  @override
  bool shouldRepaint(FluffyCloudPainter oldDelegate) => false;
}
