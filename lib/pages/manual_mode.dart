import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../widgets/animated_background.dart';

class ManualModePage extends StatelessWidget {
  const ManualModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(
            title: 'Manual Mode',
          ),
          body: AnimatedBackground(
            isDark: themeProvider.isDark,
            child: SafeArea(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: themeProvider.isDark
                        ? Colors.grey.shade900
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade200.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, size: 60, color: Colors.pink),
                      const SizedBox(height: 16),
                      Text(
                        "Manual Help Mode",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: themeProvider.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Use this mode to send a help request or contact guardians directly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: themeProvider.isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement help request logic here
                        },
                        icon: const Icon(Icons.send, color: Colors.white),
                        label: const Text(
                          "Send Help Request",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade400,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
