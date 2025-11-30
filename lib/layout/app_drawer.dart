import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade300, Colors.pink.shade600],
              ),
            ),
            child: Text(
              'SafeHer Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.pink.shade600),
            title: Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.blue.shade600),
            title: Text('Location/Map'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/map');
            },
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.green.shade600),
            title: Text('Manual Mode'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/manual_mode');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.purple.shade600),
            title: Text('My Guardians'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/guardians');
            },
          ),
          ListTile(
            leading: Icon(Icons.mic, color: Colors.orange.shade600),
            title: Text('Recordings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/recordings');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shield, color: Colors.red.shade600),
            title: Text('Self Defense'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/self_defense');
            },
          ),
          
          Divider(),
          
          // ✨ Beautiful Dark Mode Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeProvider.isDark
                          ? [Colors.grey.shade800, Colors.grey.shade900]
                          : [Colors.pink.shade50, Colors.purple.shade50],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: themeProvider.isDark
                          ? Colors.grey.shade700
                          : Colors.pink.shade200,
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        themeProvider.toggleTheme();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Animated icon with background
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: themeProvider.isDark
                                    ? Colors.amber.withOpacity(0.2)
                                    : Colors.indigo.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                themeProvider.isDark
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                color: themeProvider.isDark
                                    ? Colors.amber.shade300
                                    : Colors.indigo.shade600,
                                size: 24,
                              ),
                            ),
                            
                            SizedBox(width: 16),
                            
                            // Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    themeProvider.isDark ? 'Dark Mode' : 'Light Mode',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: themeProvider.isDark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Tap to switch',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: themeProvider.isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Arrow indicator
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: themeProvider.isDark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
