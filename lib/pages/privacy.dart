import 'package:flutter/material.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool location = true;
  bool message = false;
  bool network = true;
  bool microphone = false;
  bool storage = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppHeader(title: "Settings & Privacy"),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        children: [
          ListTile(
            leading: Icon(Icons.security, color: Colors.purple),
            title: Text("Change Password"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, '/change_password');
            },
          ),
          const Divider(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Sensor Permissions",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.pink.shade400)),
          ),
          SwitchListTile(
            activeThumbColor: Colors.pink.shade400,
            secondary: Icon(Icons.location_on, color: Colors.blueAccent),
            title: Text("Location"),
            value: location,
            onChanged: (val) {
              setState(() => location = val);
            },
          ),
          SwitchListTile(
            activeThumbColor: Colors.pink.shade400,
            secondary: Icon(Icons.sms, color: Colors.deepPurple),
            title: Text("Messages"),
            value: message,
            onChanged: (val) {
              setState(() => message = val);
            },
          ),
          SwitchListTile(
            activeThumbColor: Colors.pink.shade400,
            secondary: Icon(Icons.wifi, color: Colors.green),
            title: Text("Network"),
            value: network,
            onChanged: (val) {
              setState(() => network = val);
            },
          ),
          SwitchListTile(
            activeThumbColor: Colors.pink.shade400,
            secondary: Icon(Icons.mic, color: Colors.redAccent),
            title: Text("Microphone"),
            value: microphone,
            onChanged: (val) {
              setState(() => microphone = val);
            },
          ),
          SwitchListTile(
            activeThumbColor: Colors.pink.shade400,
            secondary: Icon(Icons.sd_storage, color: Colors.amber),
            title: Text("Storage"),
            value: storage,
            onChanged: (val) {
              setState(() => storage = val);
            },
          ),
          const Divider(height: 34),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.blue),
            title: Text("Privacy Policy"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Privacy Policy"),
                  content: Text("Your privacy is important..."),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Close"))],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.green),
            title: Text("About SafeHer"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "SafeHer",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 SafeHer Team",
              );
            },
          ),
        ],
      ),
    );
  }
}
