import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';

/// Reactive ThemeController managing light/dark switching with persistent storage
class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  late final Rx<ThemeMode> _themeMode;
  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    final saved = _storageService.getThemeMode();
    _themeMode = (saved == 'dark' ? ThemeMode.dark : ThemeMode.light).obs;
  }

  void toggleTheme() {
    if (isDarkMode) {
      setTheme(ThemeMode.light);
    } else {
      setTheme(ThemeMode.dark);
    }
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    _storageService.saveThemeMode(mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
