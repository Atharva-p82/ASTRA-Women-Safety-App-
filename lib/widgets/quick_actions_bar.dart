import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildActionItem(
                context,
                'Map',
                Icons.map,
                Colors.blue.shade400,
                '/map',
                themeProvider.isDark,
              ),
              SizedBox(width: 12),
              _buildActionItem(
                context,
                'Help',
                Icons.help,
                Colors.green.shade400,
                '/help',
                themeProvider.isDark,
              ),
              SizedBox(width: 12),
              _buildActionItem(
                context,
                'Recordings',
                Icons.mic,
                Colors.orange.shade400,
                '/recordings',
                themeProvider.isDark,
              ),
              SizedBox(width: 12),
              _buildActionItem(
                context,
                'Self Defense',
                Icons.shield,
                Colors.purple.shade400,
                '/self_defense',
                themeProvider.isDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String route,
    bool isDark,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: color),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

