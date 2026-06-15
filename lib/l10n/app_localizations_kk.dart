// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get alwaysDisplayOn => 'Экран әрқашан қосулы';

  @override
  String get appName => 'Менің Мұсхафым';

  @override
  String get appTheme => 'Қолданба тақырыбы';

  @override
  String get arabic => 'Арабша';

  @override
  String get arabicAyah => 'Аятты арабша';

  @override
  String get arabicSurahName => 'Сүренің арабша атауы';

  @override
  String get ayah => 'Аят';

  @override
  String get ayahs => 'Аяттар';

  @override
  String ayahsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count аят',
      many: '$count аят',
      few: '$count аят',
      one: '$count аят',
    );
    return '$_temp0';
  }

  @override
  String searchResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нәтиже табылды',
      many: '$count нәтиже табылды',
      few: '$count нәтиже табылды',
      one: '$count нәтиже табылды',
      zero: 'ештеңе табылмады',
    );
    return '$_temp0';
  }

  @override
  String searchByQuery(String query, String matches) {
    return '«$query» сұранысы бойынша↵$matches';
  }

  @override
  String get enterSearchQuery => 'Іздеу үшін сұраныс енгізіңіз';

  @override
  String get searchNoResults => 'Ештеңе табылмады';

  @override
  String searchError(String error) {
    return 'Іздеу қатесі: $error';
  }

  @override
  String get ayahsTextSize => 'Аят мәтінінің өлшемі';

  @override
  String get bookmarks => 'Таңдаулылар';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get defaultSettings => 'Зауыттық параметрлер';

  @override
  String get delete => 'Жою';

  @override
  String get deleteAllBookmarks => 'Барлық таңдаулыларды жою';

  @override
  String get errorDbInit => 'Деректер қорын инициализациялау қатесі';

  @override
  String get hizb => 'Хизб';

  @override
  String get hizbs => 'Хизбтер';

  @override
  String get initializingData => 'Деректер инициализациялануда…';

  @override
  String get juz => 'Жүз';

  @override
  String get juzs => 'Жүздер';

  @override
  String get listIsEmpty => 'Тізім бос';

  @override
  String get medina => 'Мәдина';

  @override
  String get mecca => 'Мекке';

  @override
  String get page => 'Бет';

  @override
  String get pageShort => 'Б.';

  @override
  String get pages => 'Беттер';

  @override
  String get recent => 'Соңғы';

  @override
  String get removedFromFavorite => 'Таңдаулылардан жойылды';

  @override
  String get reset => 'Қалпына келтіру';

  @override
  String get retry => 'Қайталап көру';

  @override
  String get semanticTranslation => 'Мағыналық аударма';

  @override
  String get mushafPage => 'Мұсхаф беті';

  @override
  String get selectThemeColor => 'Тақырып түсін таңдаңыз';

  @override
  String get settings => 'Параметрлер';

  @override
  String get surah => 'Сүре';

  @override
  String get surahs => 'Сүрелер';

  @override
  String get themeColor => 'Тақырып түсі';

  @override
  String get themeDark => 'Қараңғы';

  @override
  String get themeLight => 'Жарық';

  @override
  String get themeSystem => 'Жүйелік';

  @override
  String get translation => 'Аударма';

  @override
  String get translationAyah => 'Аяттың аудармасы';

  @override
  String get addToFavorite => 'Таңдаулыларға қосу';

  @override
  String get removeFromFavorite => 'Таңдаулылардан жою';

  @override
  String get jumpToPage => 'Бетке өту';

  @override
  String get goTo => 'Өту…';

  @override
  String get searchAyahs => 'Аяттарды іздеу';

  @override
  String get translationSurahName => 'Сүре атауының аудармасы';
}
