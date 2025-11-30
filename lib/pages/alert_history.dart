import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_header.dart';
import '../layout/app_drawer.dart';

class AlertHistoryPage extends StatelessWidget {
  const AlertHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AlertProvider, ThemeProvider>(
      builder: (context, alertProvider, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(title: "Alert History"),
          body: Container(
            color: themeProvider.isDark ? Colors.black : Colors.white,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.pink.shade600,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.pink.shade600,
                    tabs: [
                      Tab(text: 'All Alerts'),
                      Tab(text: 'Recordings'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // All Alerts Tab
                        ListView(
                          padding: EdgeInsets.all(16),
                          children: [
                            _alertHistoryItem(
                              'True Alert',
                              'Today at 2:30 PM',
                              Colors.red,
                              'Emergency confirmed',
                              themeProvider.isDark,
                            ),
                            SizedBox(height: 12),
                            _alertHistoryItem(
                              'False Alarm',
                              'Yesterday at 5:15 PM',
                              Colors.orange,
                              'User confirmed false alarm',
                              themeProvider.isDark,
                            ),
                            SizedBox(height: 12),
                            _alertHistoryItem(
                              'True Alert',
                              '2 days ago at 3:45 PM',
                              Colors.red,
                              'Emergency confirmed',
                              themeProvider.isDark,
                            ),
                          ],
                        ),
                        // Recordings Tab
                        ListView(
                          padding: EdgeInsets.all(16),
                          children: [
                            _recordingItem(
                              'Recording_001.mp3',
                              'Today at 2:30 PM',
                              '2:45 min',
                              themeProvider.isDark,
                            ),
                            SizedBox(height: 12),
                            _recordingItem(
                              'Recording_002.mp3',
                              'Yesterday at 5:15 PM',
                              '1:20 min',
                              themeProvider.isDark,
                            ),
                          ],
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
    );
  }

  Widget _alertHistoryItem(
    String type,
    String time,
    Color color,
    String status,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(
              type == 'True Alert' ? Icons.warning : Icons.check_circle,
              color: color,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recordingItem(String name, String time, String duration, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(Icons.mic, color: Colors.orange.shade400),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            duration,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          SizedBox(width: 12),
          Icon(Icons.play_arrow, color: Colors.pink.shade400),
        ],
      ),
    );
  }
}
