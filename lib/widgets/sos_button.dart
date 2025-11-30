import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SOSButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isDark;

  const SOSButton({
    super.key,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double> _rippleAnim;
  late Animation<double> _shineAnim;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    )..repeat();
    _rippleAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _mainController, curve: Curves.easeOut));
    _shineAnim = Tween<double>(begin: -1.2, end: 2.1)
        .animate(CurvedAnimation(parent: _mainController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = 180; // Increased from 144 to 180 (+25%)

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: buttonSize + 60,
          height: buttonSize + 60,
          child: AnimatedBuilder(
            animation: _mainController,
            builder: (context, child) {
              double rippleSize = buttonSize + (_rippleAnim.value * 60); // Bigger ripple spread
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple ring (enhanced)
                  Container(
                    width: rippleSize,
                    height: rippleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red.shade500
                            .withOpacity((1 - _rippleAnim.value) * 0.35), // More visible
                        width: 12 - (_rippleAnim.value * 10), // Thicker ripple
                      ),
                    ),
                  ),
                  // Main button (larger)
                  GestureDetector(
                    onTap: widget.onPressed,
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade300,
                            Colors.red.shade500,
                            Colors.red.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade300.withOpacity(0.4), // Stronger shadow
                            blurRadius: 28,
                            spreadRadius: 12,
                          ),
                          BoxShadow(
                            color: Colors.red.shade900.withOpacity(0.2),
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                              size: 58, // Increased from 45
                            ),
                            SizedBox(height: 10),
                            Text(
                              "SOS",
                              style: GoogleFonts.montserrat(
                                fontSize: 42, // Increased from 32
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Alert",
                              style: GoogleFonts.montserrat(
                                fontSize: 14, // Increased from 12
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Static shine layer (enhanced)
                  IgnorePointer(
                    child: CustomPaint(
                      size: Size(buttonSize, buttonSize),
                      painter: StaticShinePainter(),
                    ),
                  ),
                  // Animated shine layer (enhanced)
                  IgnorePointer(
                    child: CustomPaint(
                      size: Size(buttonSize, buttonSize),
                      painter: _ShinePainter(_shineAnim.value),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 18),
        Text(
          "Tap Instantly to Alert Guardians",
          style: GoogleFonts.montserrat(
            fontSize: 14, // Increased from 13
            color: widget.isDark
                ? Colors.grey.shade300
                : Colors.grey.shade700,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ---- Animated Shine Painter (Enhanced) ----
class _ShinePainter extends CustomPainter {
  final double dx;
  _ShinePainter(this.dx);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment(-1, -1),
      end: Alignment(1, 1),
      stops: [dx - 0.15, dx, dx + 0.15],
      colors: [
        Colors.transparent,
        Colors.white.withOpacity(0.42), // Brighter shine
        Colors.transparent,
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..blendMode = BlendMode.luminosity;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ShinePainter old) => true;
}

// ---- Static Shine Painter (Enhanced) ----
class StaticShinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.52, 0.62, 0.76],
      colors: [
        Colors.transparent,
        Colors.white.withOpacity(0.26), // Brighter static shine
        Colors.transparent,
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..blendMode = BlendMode.luminosity;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(StaticShinePainter oldDelegate) => false;
}
