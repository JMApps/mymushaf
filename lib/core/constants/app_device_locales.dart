import 'dart:ui';

class AppDeviceLocales {
  AppDeviceLocales._();

  static const List<Locale> appLocales = [
    Locale('ru'),
    Locale('en'),
    Locale('kg'),
    Locale('uz'),
    Locale('az'),
    Locale('kk'),
  ];

  static const Map<String, int> defaultTranslationIndex = {
    'ru': 0,
    'en': 1,
    'kg': 2,
    'uz': 3,
    'az': 4,
    'kk': 5,
  };

  static const List<({String name, String column})> ayahTranslations = [
    (name: '[RU] Кулиев', column: 'ayah_ru_kuliev'),
    (name: '[RU] Абу Адель', column: 'ayah_ru_adel'),
    (name: '[KG] Ш. Хакимов', column: 'ayah_kg'),
    (name: '[UZ] М. Содик', column: 'ayah_uz'),
    (name: '[AZ] А. Мусаев', column: 'ayah_az'),
    (name: '[KK] Х. Алтай', column: 'ayah_kk'),
  ];
}
