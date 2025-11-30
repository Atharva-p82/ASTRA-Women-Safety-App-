import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertModeToggle extends StatefulWidget {
  const AlertModeToggle({super.key});

  @override
  State<AlertModeToggle> createState() => _AlertModeToggleState();
}

class _AlertModeToggleState extends State<AlertModeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  double _dragPosition = 0;
  bool _isAlert = false;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final containerWidth = 340.0;
    final thumbWidth = 60.0;
    final maxDrag = containerWidth - thumbWidth - 16;

    setState(() {
      _isDragging = true;
      _dragPosition =
          ((_dragPosition * maxDrag) + details.delta.dx).clamp(0, maxDrag) /
              maxDrag;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      if (_dragPosition > 0.5) {
        _dragPosition = 1.0;
        if (!_isAlert) {
          _isAlert = true;
          _glowController.forward(from: 0);
        }
      } else {
        _dragPosition = 0.0;
        _isAlert = false;
        _glowController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color normalColor = Color(0xFF7C3AED);
    final Color alertColor = Color(0xFFE94057);
    final Color currentColor =
        Color.lerp(normalColor, alertColor, _dragPosition) ?? normalColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // Status text - FIXED at top center
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 300),
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: _dragPosition > 0.5 ? alertColor : normalColor,
              letterSpacing: 2.2,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.easeInBack,
              child: Text(
                _dragPosition > 0.5 ? "ALERT ACTIVE" : "NORMAL MODE",
                key: ValueKey(_dragPosition > 0.5),
              ),
            ),
          ),
          SizedBox(height: 14),
          // Slider toggle
          MouseRegion(
            cursor: SystemMouseCursors.grab,
            onEnter: (_) => setState(() {}),
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 280),
                height: 76,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: _dragPosition > 0.4
                        ? [
                            alertColor.withOpacity(0.08),
                            alertColor.withOpacity(0.04),
                          ]
                        : [
                            normalColor.withOpacity(0.08),
                            normalColor.withOpacity(0.04),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: currentColor.withOpacity(0.25),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: Offset(0, 6),
                    ),
                    if (_isAlert)
                      BoxShadow(
                        color: alertColor.withOpacity(0.15),
                        blurRadius: 32,
                        spreadRadius: 8,
                        offset: Offset(0, 8),
                      ),
                  ],
                  border: Border.all(
                    color: currentColor,
                    width: 3,
                  ),
                ),
                child: Stack(
                  children: [
                    // Background text left
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NORMAL",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: normalColor.withOpacity(0.4),
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              "Mode",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: normalColor.withOpacity(0.25),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Background text right
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "ALERT",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: alertColor.withOpacity(0.4),
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              "Active",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: alertColor.withOpacity(0.25),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Animated sliding thumb
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        final glowRadius = 16 + (_pulseAnimation.value * 20);
                        return Align(
                          alignment: Alignment(_dragPosition * 2 - 1, 0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.lerp(
                                  Colors.white,
                                  alertColor,
                                  _dragPosition,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: currentColor.withOpacity(0.3),
                                    blurRadius: 18 + (_dragPosition * 14),
                                    spreadRadius: 2,
                                  ),
                                  if (_isAlert)
                                    BoxShadow(
                                      color: alertColor.withOpacity(
                                          0.4 * (1 - _pulseAnimation.value)),
                                      blurRadius: glowRadius,
                                      spreadRadius: _pulseAnimation.value * 6,
                                    ),
                                ],
                                border: Border.all(
                                  color: currentColor,
                                  width: 3,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Main icon
                                  Center(
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 400),
                                      switchInCurve: Curves.elasticOut,
                                      switchOutCurve: Curves.elasticIn,
                                      child: _dragPosition > 0.5
                                          ? Transform.rotate(
                                              angle:
                                                  _pulseAnimation.value * 0.3,
                                              child: Icon(
                                                Icons.bolt_rounded,
                                                key: ValueKey(1),
                                                color: Colors.white,
                                                size: 32,
                                              ),
                                            )
                                          : Icon(
                                              Icons.shield_rounded,
                                              key: ValueKey(0),
                                              color: normalColor,
                                              size: 32,
                                            ),
                                    )
                                  ),
                                  // Shine effect
                                  Positioned(
                                    left: 10,
                                    top: 8,
                                    child: Container(
                                      width: 28,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.7),
                                            Colors.white.withOpacity(0.1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
