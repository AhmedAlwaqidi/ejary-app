import 'package:get/get.dart';
import 'ar_translation.dart';
import 'en_translation.dart';

/// Centralized GetX Translations root
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': arTranslations,
        'en': enTranslations,
      };
}
