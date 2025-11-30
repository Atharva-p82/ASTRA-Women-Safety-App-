import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/alert_provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const AppHeader({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AlertProvider>(
      builder: (context, userProvider, alertProvider, _) {
        return AppBar(
          // Hamburger icon (Drawer trigger)
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.pink.shade400),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: 'Menu',
          ),
          title: Text(
            title ?? 'SafeHer',
            style: TextStyle(
              color: Colors.pink.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.pink.shade50,
          foregroundColor: Colors.pink.shade700,
          elevation: 0,
          actions: [
            // Home button
            IconButton(
              icon: Icon(Icons.home, color: Colors.pink.shade400),
              tooltip: "Go to Home",
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/main_layout',
                  (route) => false,
                );
              },
            ),
            
            // Notification Bell Icon with Badge - TOP RIGHT MOST
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Colors.pink.shade400,
                    size: 28,
                  ),
                  tooltip: 'Notifications',
                  onPressed: () {
                    Navigator.pushNamed(context, '/alerts');
                  },
                ),
                // Red badge for unread notifications
                if (alertProvider.hasUnreadAlerts)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${alertProvider.unreadCount > 9 ? '9+' : alertProvider.unreadCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(width: 8),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
