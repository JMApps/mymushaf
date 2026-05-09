import 'dart:ui';

class AppDeviceLocales {
  AppDeviceLocales._();

  static const List<Locale> appLocales = [
    Locale('ru'),
    Locale('en'),
    Locale('kg'),
    Locale('uz'),
    Locale('az'),
  ];

  static const Map<String, int> defaultTranslationIndex = {
    'ru': 0,
    'en': 1,
    'kg': 2,
    'uz': 3,
    'az': 4,
  };

  static const List<({String name, String column})> ayahTranslations = [
    (name: 'Кулиев', column: 'ayah_ru_kuliev'),
    (name: 'Абу Адель', column: 'ayah_ru_adel'),
    (name: 'Kyrgyz', column: 'ayah_kg'),
    (name: 'Uzbek', column: 'ayah_uz'),
    (name: 'Azerbaijan', column: 'ayah_az'),
  ];
}
