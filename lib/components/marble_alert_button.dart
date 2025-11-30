import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarbleAlertButton extends StatefulWidget {
  final bool isDark;
  final VoidCallback onAlertTriggered;
  const MarbleAlertButton({
    super.key,
    required this.isDark,
    required this.onAlertTriggered,
  });

  @override
  State<MarbleAlertButton> createState() => _MarbleAlertButtonState();
}

class _MarbleAlertButtonState extends State<MarbleAlertButton>
    with SingleTickerProviderStateMixin {
  bool isListening = false;
  bool showCancelDialog = false;
  int countdown = 15;

  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.04).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void toggleListening() async {
    if (!isListening) {
      // In a real app: request microphone
      // Simulate grant always
      setState(() {
        isListening = true;
      });
      Future.delayed(Duration(seconds: 10), () {
        if (mounted && isListening) {
          setState(() {
            showCancelDialog = true;
            countdown = 15;
          });
          _runCountdown();
        }
      });
    } else {
      setState(() {
        isListening = false;
      });
    }
  }

  void _runCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && showCancelDialog && countdown > 0) {
        setState(() {
          countdown--;
        });
        return countdown > 0;
      }
      return false;
    }).then((_) {
      if (mounted && showCancelDialog && countdown == 0) {
        handleSendAlert();
      }
    });
  }

  void handleSendAlert() {
    setState(() {
      showCancelDialog = false;
      isListening = false;
    });
    widget.onAlertTriggered();
  }

  void handleCancelAlert() {
    setState(() {
      showCancelDialog = false;
      countdown = 15;
    });
    // Continue listening
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isListening ? _scaleAnimation.value : 1.0,
                child: GestureDetector(
                  onTap: toggleListening,
                  child: Container(
                    width: 290,
                    height: 290,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: Alignment(-.3, -.3),
                        radius: 0.9,
                        colors: isListening
                            ? [
                                Colors.white.withOpacity(0.9),
                                Color(0xffff6b7a).withOpacity(0.7),
                                Color(0x00ed4866).withOpacity(1),
                                Color(0x00c83250).withOpacity(1),
                                Color(0x00ffc0d9).withOpacity(0.6),
                              ]
                            : [
                                Colors.white.withOpacity(0.8),
                                Color(0x00ffc0d9).withOpacity(0.6),
                                Color(0x00ed4866).withOpacity(0.4),
                              ],
                        stops: isListening
                            ? [0, 0.25, 0.5, 0.75, 1]
                            : [0, 0.4, 1],
                      ),
                      boxShadow: [
                        if (isListening)
                          BoxShadow(
                            color: Color(0x00ed4866).withOpacity(0.6),
                            blurRadius: 60,
                          ),
                        if (isListening)
                          BoxShadow(
                            color: Color(0x00ed4866).withOpacity(0.3),
                            blurRadius: 120,
                          ),
                        BoxShadow(
                          color: Color(0x00ed4866).withOpacity(
                              isListening ? 0.2 : 0.3),
                          blurRadius: isListening ? 40 : 20,
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Glass shine effect
                        Positioned(
                          top: 28,
                          left: 48,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.transparent
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isListening ? Icons.mic : Icons.mic_off,
                                size: 68,
                                color: isListening
                                    ? Colors.white
                                    : Colors.pink.shade700,
                                shadows: [
                                  Shadow(
                                    blurRadius: 12,
                                    color: isListening
                                        ? Colors.white
                                        : Colors.pink.shade200,
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),
                              Text(
                                isListening
                                    ? "Listening..."
                                    : "Alert Mode: OFF",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: isListening
                                      ? Colors.white
                                      : isDark
                                          ? Colors.purple.shade200
                                          : Colors.purple.shade700,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 8,
                                        color: isListening
                                            ? Colors.white
                                            : Colors.purple.shade200)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            isListening
                ? "🎤 Monitoring for distress signals... Tap to stop."
                : "Tap the button to activate alert mode. App will listen for screams or trigger words.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color:
                  isDark ? Colors.purple.shade300 : Colors.purple.shade600,
            ),
          ),
        ),
        if (showCancelDialog) _buildCancelDialog(context, isDark),
      ],
    );
  }

  Widget _buildCancelDialog(BuildContext context, bool isDark) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 60.0),
      backgroundColor:
          isDark ? Colors.black.withOpacity(0.97) : Colors.white.withOpacity(0.99),
      child: Container(
        padding: EdgeInsets.all(28),
        constraints: BoxConstraints(maxWidth: 380),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.orange.shade500, size: 32),
                SizedBox(width: 8),
                Text(
                  "Distress Detected!",
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.pink.shade300 : Colors.pink.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            Text(
              "SOS alert will be sent in",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: isDark ? Colors.purple.shade300 : Colors.purple.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text("$countdown",
                style: GoogleFonts.montserrat(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade600)),
            SizedBox(height: 12),
            LinearProgressIndicator(
              minHeight: 5,
              value: countdown / 15,
              color: Colors.pink.shade500,
              backgroundColor: Colors.grey.shade200,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: handleCancelAlert,
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Colors.grey.shade300, width: 2),
                        minimumSize: Size(0, 52)),
                    child: Text("False Alarm",
                        style: TextStyle(fontSize: 17)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: handleSendAlert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade500,
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 52),
                    ),
                    child: Text("Send Now", style: TextStyle(fontSize: 17)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
