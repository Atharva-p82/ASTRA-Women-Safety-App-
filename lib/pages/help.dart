import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../widgets/animated_background.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(
            title: 'Help & Support',
          ),
          body: AnimatedBackground(
            isDark: themeProvider.isDark,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Use SafeHer',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _helpSection(
                      'Emergency Alert',
                      'Tap the big red SOS button on the home screen to send emergency alerts to your guardians.',
                      Icons.warning,
                      themeProvider.isDark,
                    ),
                    const SizedBox(height: 16),

                    _helpSection(
                      'Alert Mode',
                      'Enable Alert Mode to let the app listen for emergencies through your microphone.',
                      Icons.mic,
                      themeProvider.isDark,
                    ),
                    const SizedBox(height: 16),

                    _helpSection(
                      'Add Guardians',
                      'Go to "My Guardians" to add trusted contacts who will receive emergency alerts.',
                      Icons.people,
                      themeProvider.isDark,
                    ),
                    const SizedBox(height: 16),

                    _helpSection(
                      'Location Sharing',
                      'Enable location permission in Privacy Settings to share your location during emergencies.',
                      Icons.location_on,
                      themeProvider.isDark,
                    ),
                    const SizedBox(height: 16),

                    _helpSection(
                      'Recordings',
                      'Access all audio recordings from emergencies in the Recordings section.',
                      Icons.mic_none,
                      themeProvider.isDark,
                    ),
                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.shade50,
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Contacts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'In case of emergency, contact local authorities immediately.\n\n'
                            'Emergency: 911 (US) or 100 (India)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _helpSection(
    String title,
    String description,
    IconData icon,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey.shade900 : Colors.white,
        border: Border.all(
          color: Colors.pink.shade200,
          width: 1,
        ),
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
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
