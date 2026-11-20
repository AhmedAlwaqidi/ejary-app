import 'package:get/get.dart';
import 'package:ejary_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ejary_app/core/theme/theme_controller.dart';
import 'package:ejary_app/core/services/storage_service.dart';
import 'package:flutter/material.dart';

/// ProfileController coordinates user preferences, language toggle, and theme switching
class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final StorageService storageService = Get.find<StorageService>();

  final RxString currentLanguage = 'ar'.obs;

  @override
  void onInit() {
    super.onInit();
    currentLanguage.value = storageService.getLanguage();
  }

  void switchLanguage(String langCode) {
    currentLanguage.value = langCode;
    storageService.saveLanguage(langCode);
    Get.updateLocale(Locale(langCode, langCode == 'ar' ? 'SA' : 'US'));
  }

  void toggleTheme() {
    themeController.toggleTheme();
  }

  Future<void> switchRole() async {
    await authController.switchRole();
  }

  Future<void> logout() async {
    await authController.logout();
  }
}
