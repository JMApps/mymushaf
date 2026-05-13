// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get alwaysDisplayOn => 'Always keep screen on';

  @override
  String get appName => 'My Mushaf';

  @override
  String get appTheme => 'App theme';

  @override
  String get arabic => 'Arabic';

  @override
  String get arabicAyah => 'Arabic ayah';

  @override
  String get arabicSurahName => 'Arabic surah name';

  @override
  String get ayah => 'Ayah';

  @override
  String get ayahs => 'Ayahs';

  @override
  String ayahsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ayahs',
      one: '$count ayah',
    );
    return '$_temp0';
  }

  @override
  String get ayahsTextSize => 'Ayah text size';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get cancel => 'Cancel';

  @override
  String get defaultSettings => 'Default settings';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAllBookmarks => 'Delete all bookmarks';

  @override
  String get errorDbInit => 'Failed to initialize database';

  @override
  String get hizb => 'Hizb';

  @override
  String get hizbs => 'Hizbs';

  @override
  String get initializingData => 'Initializing data…';

  @override
  String get juz => 'Juz';

  @override
  String get juzs => 'Juzs';

  @override
  String get listIsEmpty => 'List is empty';

  @override
  String get medina => 'Medina';

  @override
  String get mecca => 'Mecca';

  @override
  String get page => 'Page';

  @override
  String get pageShort => 'p.';

  @override
  String get pages => 'Pages';

  @override
  String get recent => 'Recent';

  @override
  String get removedFromFavorite => 'Removed from bookmarks';

  @override
  String get reset => 'Reset';

  @override
  String get retry => 'Retry';

  @override
  String get semanticTranslation => 'Semantic translation';

  @override
  String get mushafPage => 'Mushaf page';

  @override
  String get selectThemeColor => 'Select theme color';

  @override
  String get settings => 'Settings';

  @override
  String get surah => 'Surah';

  @override
  String get surahs => 'Surahs';

  @override
  String get themeColor => 'Theme color';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get translation => 'Translation';

  @override
  String get translationAyah => 'Ayah translation';

  @override
  String get addToFavorite => 'Add to favorite';

  @override
  String get removeFromFavorite => 'Remove from favorite';

  @override
  String get jumpToPage => 'Jump to page';

  @override
  String get goTo => 'Go to...';

  @override
  String get translationSurahName => 'Surah name translation';
}
