import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../providers/alert_provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_header.dart';
import '../layout/app_drawer.dart'; // <-- Don't forget this import!

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Drawer for hamburger menu!
      drawer: AppDrawer(),
      appBar: AppHeader(title: 'Notifications'),
      body: Consumer2<AlertProvider, ThemeProvider>(
        builder: (context, alertProvider, themeProvider, _) {
          final alerts = alertProvider.alerts;

          if (alerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Mark all as read button
              if (alertProvider.hasUnreadAlerts)
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        alertProvider.markAllAsRead();
                      },
                      icon: Icon(Icons.done_all),
                      label: Text('Mark all as read'),
                    ),
                  ),
                ),

              // Notifications list
              Expanded(
                child: ListView.builder(
                  itemCount: alerts.length,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return _buildAlertCard(
                      context,
                      alert,
                      alertProvider,
                      themeProvider,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAlertCard(
    BuildContext context,
    AlertModel alert,
    AlertProvider alertProvider,
    ThemeProvider themeProvider,
  ) {
    final timeAgo = _getTimeAgo(alert.timestamp);

    Color iconColor;
    IconData icon;

    switch (alert.type) {
      case 'sos':
        iconColor = Colors.red;
        icon = Icons.warning;
        break;
      case 'guardian_alert':
        iconColor = Colors.orange;
        icon = Icons.shield;
        break;
      default:
        iconColor = Colors.blue;
        icon = Icons.info;
    }

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      color: alert.isRead
          ? (themeProvider.isDark ? Colors.grey.shade900 : Colors.white)
          : (themeProvider.isDark
              ? Colors.grey.shade800
              : Colors.blue.shade50),
      elevation: alert.isRead ? 1 : 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          alert.title,
          style: GoogleFonts.montserrat(
            fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(alert.message),
            SizedBox(height: 4),
            Text(
              timeAgo,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: !alert.isRead
            ? IconButton(
                icon: Icon(Icons.check_circle_outline, color: Colors.green),
                onPressed: () {
                  alertProvider.markAsRead(alert.id);
                },
              )
            : null,
        onTap: () {
          if (!alert.isRead) {
            alertProvider.markAsRead(alert.id);
          }
        },
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, yyyy').format(timestamp);
    }
  }
}
