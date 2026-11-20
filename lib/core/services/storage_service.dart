import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/app_constants.dart';

/// Permanent GetxService wrapper around GetStorage
class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Generic write & read
  T? read<T>(String key) => _box.read<T>(key);
  Future<void> write(String key, dynamic value) => _box.write(key, value);
  Future<void> remove(String key) => _box.remove(key);
  Future<void> erase() => _box.erase();

  // Language Preference
  String getLanguage() {
    return _box.read<String>(AppConstants.keyLanguage) ?? AppConstants.defaultLanguage;
  }

  Future<void> saveLanguage(String langCode) {
    return _box.write(AppConstants.keyLanguage, langCode);
  }

  // Theme Preference
  String getThemeMode() {
    return _box.read<String>(AppConstants.keyThemeMode) ?? AppConstants.defaultTheme;
  }

  Future<void> saveThemeMode(String themeMode) {
    return _box.write(AppConstants.keyThemeMode, themeMode);
  }

  // User Role Preference
  String getUserRole() {
    return _box.read<String>(AppConstants.keyUserRole) ?? AppConstants.roleTenant;
  }

  Future<void> saveUserRole(String role) {
    return _box.write(AppConstants.keyUserRole, role);
  }
}
