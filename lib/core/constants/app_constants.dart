/// Global application constants and storage keys
class AppConstants {
  AppConstants._();

  static const String appName = 'Ejary';
  static const String appNameAr = 'إيجاري';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyThemeMode = 'ejary_theme_mode';
  static const String keyLanguage = 'ejary_language_code';
  static const String keyUserRole = 'ejary_user_role';
  static const String keyIsLoggedIn = 'ejary_is_logged_in';
  static const String keyActiveUser = 'ejary_active_user';

  // Default values
  static const String defaultLanguage = 'ar';
  static const String defaultCountry = 'SA';
  static const String defaultTheme = 'light';
  static const String roleTenant = 'tenant';
  static const String roleLandlord = 'landlord';

  // Currency
  static const String currencySarAr = 'ر.س';
  static const String currencySarEn = 'SAR';
}
