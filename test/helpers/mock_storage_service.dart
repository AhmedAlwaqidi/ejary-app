import 'package:ejary_app/core/services/storage_service.dart';
import 'package:ejary_app/core/constants/app_constants.dart';

/// In-memory MockStorageService for automated tests
class MockStorageService extends StorageService {
  final Map<String, dynamic> _memory = {};

  @override
  Future<StorageService> init() async => this;

  @override
  T? read<T>(String key) => _memory[key] as T?;

  @override
  Future<void> write(String key, dynamic value) async {
    _memory[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _memory.remove(key);
  }

  @override
  Future<void> erase() async {
    _memory.clear();
  }

  @override
  String getLanguage() =>
      _memory[AppConstants.keyLanguage] as String? ?? AppConstants.defaultLanguage;

  @override
  Future<void> saveLanguage(String langCode) async {
    _memory[AppConstants.keyLanguage] = langCode;
  }

  @override
  String getThemeMode() =>
      _memory[AppConstants.keyThemeMode] as String? ?? AppConstants.defaultTheme;

  @override
  Future<void> saveThemeMode(String themeMode) async {
    _memory[AppConstants.keyThemeMode] = themeMode;
  }

  @override
  String getUserRole() =>
      _memory[AppConstants.keyUserRole] as String? ?? AppConstants.roleTenant;

  @override
  Future<void> saveUserRole(String role) async {
    _memory[AppConstants.keyUserRole] = role;
  }
}
