// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kongo (`kg`).
class AppLocalizationsKg extends AppLocalizations {
  AppLocalizationsKg([String locale = 'kg']) : super(locale);

  @override
  String get alwaysDisplayOn => 'Экран дайыма күйүк';

  @override
  String get appName => 'Менин Мусхабым';

  @override
  String get appTheme => 'Колдонмонун темасы';

  @override
  String get arabic => 'Арабча';

  @override
  String get arabicAyah => 'Аятты арабча';

  @override
  String get arabicSurahName => 'Сүрөнүн арабча аты';

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
      other: '$count натыйжа табылды',
      many: '$count натыйжа табылды',
      few: '$count натыйжа табылды',
      one: '$count натыйжа табылды',
      zero: 'эч нерсе табылган жок',
    );
    return '$_temp0';
  }

  @override
  String searchByQuery(String query, String matches) {
    return '«$query» суроо боюнча↵$matches';
  }

  @override
  String get enterSearchQuery => 'Издөө үчүн суроо киргизиңиз';

  @override
  String get searchNoResults => 'Эч нерсе табылган жок';

  @override
  String searchError(String error) {
    return 'Издөө катасы: $error';
  }

  @override
  String get ayahsTextSize => 'Аят тексттин өлчөмү';

  @override
  String get bookmarks => 'Сүйүктүүлөр';

  @override
  String get cancel => 'Жокко чыгаруу';

  @override
  String get defaultSettings => 'Завод жөндөөлөрү';

  @override
  String get delete => 'Жок кылуу';

  @override
  String get deleteAllBookmarks => 'Бардык сүйүктүүлөрдү жок кылуу';

  @override
  String get errorDbInit => 'Маалымат базасын инициализациялоо катасы';

  @override
  String get hizb => 'Хизб';

  @override
  String get hizbs => 'Хизбдер';

  @override
  String get initializingData => 'Маалыматтар инициализацияланууда…';

  @override
  String get juz => 'Жуз';

  @override
  String get juzs => 'Жуздар';

  @override
  String get listIsEmpty => 'Тизме бош';

  @override
  String get medina => 'Мадина';

  @override
  String get mecca => 'Мекке';

  @override
  String get page => 'Бет';

  @override
  String get pageShort => 'Б.';

  @override
  String get pages => 'Беттер';

  @override
  String get recent => 'Акыркы';

  @override
  String get removedFromFavorite => 'Сүйүктүүлөрдөн жок кылынды';

  @override
  String get reset => 'Баштапкы абалга келтирүү';

  @override
  String get retry => 'Кайра аракет кылуу';

  @override
  String get semanticTranslation => 'Маанилик котормо';

  @override
  String get mushafPage => 'Мусхаф бети';

  @override
  String get selectThemeColor => 'Тема түсүн тандаңыз';

  @override
  String get settings => 'Жөндөөлөр';

  @override
  String get surah => 'Сүрө';

  @override
  String get surahs => 'Сүрөлөр';

  @override
  String get themeColor => 'Тема түсү';

  @override
  String get themeDark => 'Кара';

  @override
  String get themeLight => 'Жарык';

  @override
  String get themeSystem => 'Тутумдук';

  @override
  String get translation => 'Котормо';

  @override
  String get translationAyah => 'Аяттын котормосу';

  @override
  String get addToFavorite => 'Сүйүктүүлөргө кошуу';

  @override
  String get removeFromFavorite => 'Сүйүктүүлөрдөн жок кылуу';

  @override
  String get jumpToPage => 'Бетке өтүү';

  @override
  String get goTo => 'Өтүү…';

  @override
  String get searchAyahs => 'Аяттарды издөө';

  @override
  String get translationSurahName => 'Сүрө атынын котормосу';
}
