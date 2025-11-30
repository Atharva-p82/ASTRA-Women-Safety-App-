import 'package:flutter/material.dart';

// Import your page routes and reusable widgets as needed.

class AppLayout extends StatefulWidget {
  final Widget child;
  final String currentPageName;
  const AppLayout({super.key, required this.child, required this.currentPageName});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool menuOpen = false;
  bool isDark = false; // You can connect this to Provider/user settings
  String userName = "User"; // Replace with actual user fetching logic
  String userEmail = "user@email.com";
  String? userAvatarUrl;
  String theme = "light";

  @override
  void initState() {
    super.initState();
    // Call your backend/auth methods here
    // simulateLoadUser();
  }

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
      theme = isDark ? "dark" : "light";
      // Save preference in backend or storage if needed
    });
  }

  void handleLogout() {
    // Call your logout logic (navigate to login page)
  }

  String getUserInitials() {
    if (userName.isEmpty) return "U";
    return userName
        .split(" ")
        .map((n) => n.isNotEmpty ? n[0] : "")
        .join("")
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bgGradient = isDark
        ? const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)])
        : const LinearGradient(colors: [Color(0xFFFDF6F6), Color(0xFFF1F1FA)]);

    // hint: for real streaming user/theme, use Provider or Bloc to update isDark/userName/userAvatarUrl
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: widget.currentPageName == "Login"
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 68,
              leading: IconButton(
                icon: menuOpen
                    ? Icon(Icons.close, color: isDark ? Colors.pink[200] : Colors.pink[600])
                    : Icon(Icons.menu, color: isDark ? Colors.pink[200] : Colors.pink[600]),
                onPressed: () => setState(() => menuOpen = !menuOpen),
              ),
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.pink.shade400, Colors.pink.shade700],
                      ),
                    ),
                    child: Icon(Icons.shield, color: Colors.white, size: 27),
                  ),
                  const SizedBox(width: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.pink, Colors.purple],
                    ).createShader(bounds),
                    child: Text(
                      "SafeHer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => buildProfileDropdown(context)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
                      backgroundColor: Colors.pink.shade400,
                      child: userAvatarUrl == null
                          ? Text(
                              getUserInitials(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
      drawer: menuOpen ? buildNavDrawer(context) : null,
      body: Stack(
        children: [
          // Animated/moving background
          DecoratedBox(
            decoration: BoxDecoration(gradient: bgGradient),
            child: Container(),
          ),
          // Animated icons or particles: You may use Positioned widgets or animated widgets here
          // ...

          SafeArea(child: widget.child),
        ],
      ),
      floatingActionButton: widget.currentPageName == "Home"
          ? FloatingActionButton(
              backgroundColor: Colors.pink.shade400,
              child: Icon(Icons.map, color: Colors.white),
              onPressed: () {
                // Navigate to map page
              },
            )
          : null,
    );
  }

  Widget buildProfileDropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink.shade400,
              backgroundImage:
                  userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
              child: userAvatarUrl == null
                  ? Text(getUserInitials(),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                  : null,
            ),
            title: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(userEmail),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.pink),
            title: Text('Account Details'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.purple),
            title: Text('Privacy Settings'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Colors.teal),
            title: Text('Switch to ${isDark ? "Light" : "Dark"} Mode'),
            onTap: toggleTheme,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Log Out'),
            onTap: handleLogout,
          ),
        ],
      ),
    );
  }

  Widget buildNavDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: isDark ? Colors.black : Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade300, Colors.pink.shade600],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 28)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.pink),
            title: Text('Help'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.timer, color: Colors.blue),
            title: Text('Manual Mode'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text('SOS Alerts'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.shield_rounded, color: Colors.purple),
            title: Text('Self Defense Techniques'),
            onTap: () {
              // Navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.mic, color: Colors.green),
            title: Text('Recordings'),
            onTap: () {
              // Navigate
            },
          ),
        ],
      ),
    );
  }
}
