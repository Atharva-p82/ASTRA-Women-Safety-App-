class Constants {
  // API Configuration
  static const String baseUrl = 'http://your-flask-backend.com/api';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String userEndpoint = '/auth/me';
  static const String guardiansEndpoint = '/guardians';
  
  // SharedPreferences Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_preference';
  
  // Theme Colors
  static const primaryPink = 0xFFED4866;
  static const primaryRose = 0xFFFF6B7A;
  static const navy = 0xFF1E3A5F;
  static const blush = 0xFFFFC0D9;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxPhoneLength = 15;
  
  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String backgroundPath = 'assets/images/background.png';
  static const String shieldIconPath = 'assets/images/icons/shield.png';
}
