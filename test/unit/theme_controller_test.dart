import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ejary_app/core/services/storage_service.dart';
import 'package:ejary_app/core/theme/theme_controller.dart';
import '../helpers/mock_storage_service.dart';

void main() {
  late MockStorageService mockStorage;

  setUp(() {
    Get.reset();
    mockStorage = MockStorageService();
    Get.put<StorageService>(mockStorage);
  });

  tearDown(() {
    Get.reset();
  });

  group('ThemeController Unit Tests', () {
    test('initializes with default light theme when storage is empty', () {
      final controller = Get.put(ThemeController());
      expect(controller.themeMode, equals(ThemeMode.light));
      expect(controller.isDarkMode, isFalse);
    });

    test('initializes with dark theme if saved in storage', () {
      mockStorage.saveThemeMode('dark');
      final controller = Get.put(ThemeController());
      expect(controller.themeMode, equals(ThemeMode.dark));
      expect(controller.isDarkMode, isTrue);
    });

    test('toggleTheme switches from light to dark and persists to storage', () {
      final controller = Get.put(ThemeController());
      expect(controller.isDarkMode, isFalse);

      controller.toggleTheme();
      expect(controller.isDarkMode, isTrue);
      expect(controller.themeMode, equals(ThemeMode.dark));
      expect(mockStorage.getThemeMode(), equals('dark'));

      controller.toggleTheme();
      expect(controller.isDarkMode, isFalse);
      expect(controller.themeMode, equals(ThemeMode.light));
      expect(mockStorage.getThemeMode(), equals('light'));
    });
  });
}
