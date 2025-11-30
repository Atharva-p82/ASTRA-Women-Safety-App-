import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'pages/home.dart';
import 'pages/account.dart' as account_page;
import 'pages/alerts.dart';
import 'pages/map.dart';
import 'pages/recordings.dart'; // Make sure your class is RecordingsPage in this file!
import 'pages/help.dart';
import 'pages/privacy.dart';
import 'pages/manual_mode.dart';
import 'pages/self_defense.dart';
import 'pages/guardians_screen.dart';
import 'pages/add_guardian_screen.dart';
import 'pages/edit_guardian_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/change_password.dart'; // <-- Import your change password page here
import 'layout/main_layout.dart';
import '../models/guardian.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String account = '/account';
  static const String alerts = '/alerts';
  static const String map = '/map';
  static const String recordings = '/recordings';
  static const String help = '/help';
  static const String privacy = '/privacy';
  static const String manualMode = '/manual_mode';
  static const String selfDefense = '/self_defense';
  static const String guardians = '/guardians';
  static const String addGuardian = '/add_guardian';
  static const String editGuardian = '/edit_guardian';
  static const String mainLayout = '/main_layout';
  static const String profile = '/profile';
  static const String changePassword = '/change_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case account:
        return MaterialPageRoute(
          builder: (_) => const account_page.AccountPage(),
        );
      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertsPage());
      case map:
        return MaterialPageRoute(builder: (_) => const MapPage());
      case recordings:
        return MaterialPageRoute(builder: (_) => const RecordingsPage());
      case help:
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case privacy:
        return MaterialPageRoute(builder: (_) => Privacy());
      case '/alerts':
        return MaterialPageRoute(builder: (_) => AlertsPage());
      case manualMode:
        return MaterialPageRoute(builder: (_) => const ManualModePage());
      case selfDefense:
        return MaterialPageRoute(builder: (_) => const SelfDefensePage());
      case guardians:
        return MaterialPageRoute(builder: (_) => const GuardiansScreen());
      case addGuardian:
        return MaterialPageRoute(builder: (_) => AddGuardianScreen());
      case editGuardian:
        final guardian = settings.arguments as Guardian;
        return MaterialPageRoute(
          builder: (_) => EditGuardianScreen(guardian: guardian),
        );
      case changePassword:
      case '/change_password':
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case mainLayout:
        return MaterialPageRoute(
          builder: (_) => MainLayout(
            pages: const [
              HomePage(),
              AlertsPage(),
              MapPage(),
              RecordingsPage(), // <-- Must exactly match the class in recordings.dart
              account_page.AccountPage(),
            ],
            pageTitles: const [
              "Home",
              "Alerts",
              "Map",
              "Recordings",
              "Profile",
            ],
            initialIndex: 0,
            isDark: false,
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
