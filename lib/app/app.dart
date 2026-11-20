import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'translations/app_translations.dart';
import 'bindings/initial_binding.dart';
import '../core/theme/light_theme.dart';
import '../core/theme/dark_theme.dart';
import '../core/theme/theme_controller.dart';
import '../core/services/storage_service.dart';

/// Root GetMaterialApp for Ejary Platform
class EjaryApp extends StatelessWidget {
  const EjaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<StorageService>();
    final themeController = Get.find<ThemeController>();
    final savedLang = storage.getLanguage();

    return Obx(
      () => GetMaterialApp(
        title: 'Ejary',
        debugShowCheckedModeBanner: false,

        // Translations & Locales
        translations: AppTranslations(),
        locale: Locale(savedLang, savedLang == 'ar' ? 'SA' : 'US'),
        fallbackLocale: const Locale('ar', 'SA'),

        // Themes
        theme: buildLightTheme(),
        darkTheme: buildDarkTheme(),
        themeMode: themeController.themeMode,

        // Routing & Global Bindings
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        initialBinding: InitialBinding(),
      ),
    );
  }
}
