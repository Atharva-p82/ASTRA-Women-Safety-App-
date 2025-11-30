import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_drawer.dart';
import '../widgets/animated_background.dart';

class SelfDefensePage extends StatelessWidget {
  const SelfDefensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: null, // Using custom header instead
          body: AnimatedBackground(
            isDark: themeProvider.isDark,
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Custom header with menu and home button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, color: Colors.pink.shade400, size: 28),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Text(
                        'Self Defense',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.home, color: Colors.pink.shade400, size: 28),
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Self-Defense Tips",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _defenseTip(
                    "Stay Alert",
                    "Always be aware of your surroundings and trust your instincts.",
                    Icons.visibility,
                    themeProvider.isDark,
                  ),
                  const SizedBox(height: 12),
                  _defenseTip(
                    "Make Noise",
                    "If you feel unsafe, create a loud noise to attract attention.",
                    Icons.volume_up,
                    themeProvider.isDark,
                  ),
                  const SizedBox(height: 12),
                  _defenseTip(
                    "Use Emergency Button",
                    "Tap the SOS button in the app to notify your guardians instantly.",
                    Icons.warning,
                    themeProvider.isDark,
                  ),
                  const SizedBox(height: 12),
                  _defenseTip(
                    "Learn Moves",
                    "Consider learning basic self-defense moves or attending workshops.",
                    Icons.fitness_center,
                    themeProvider.isDark,
                  ),
                  const SizedBox(height: 24),
                  _extraTipCard(themeProvider.isDark),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _defenseTip(String title, String description, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey.shade900 : Colors.white,
        border: Border.all(color: Colors.pink.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade100.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.pink.shade400, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _extraTipCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark
            ? Colors.blueGrey.shade900.withOpacity(0.4)
            : Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: Colors.blue.shade400, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Remember: Confidence is key! Keep calm and take control of the situation when possible.",
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
