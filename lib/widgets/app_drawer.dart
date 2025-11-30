import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
