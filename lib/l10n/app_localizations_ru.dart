// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get alwaysDisplayOn => 'Дисплей всегда включён';

  @override
  String get appName => 'Мой Мусхаф';

  @override
  String get appTheme => 'Тема приложения';

  @override
  String get arabic => 'Арабский';

  @override
  String get arabicAyah => 'Аят на арабском';

  @override
  String get arabicSurahName => 'Название суры на арабском';

  @override
  String get ayah => 'Аят';

  @override
  String get ayahs => 'Аяты';

  @override
  String ayahsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count аята',
      many: '$count аятов',
      few: '$count аята',
      one: '$count аят',
    );
    return '$_temp0';
  }

  @override
  String get ayahsTextSize => 'Размер текста аята';

  @override
  String get bookmarks => 'Избранное';

  @override
  String get cancel => 'Отмена';

  @override
  String get defaultSettings => 'Заводские настройки';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteAllBookmarks => 'Удалить всё избранное';

  @override
  String get errorDbInit => 'Ошибка инициализации базы данных';

  @override
  String get hizb => 'Хизб';

  @override
  String get hizbs => 'Хизбы';

  @override
  String get initializingData => 'Инициализация данных…';

  @override
  String get juz => 'Джуз';

  @override
  String get juzs => 'Джузы';

  @override
  String get listIsEmpty => 'Список пуст';

  @override
  String get medina => 'Медина';

  @override
  String get mecca => 'Мекка';

  @override
  String get page => 'Страница';

  @override
  String get pageShort => 'Стр.';

  @override
  String get pages => 'Страницы';

  @override
  String get recent => 'Последние';

  @override
  String get removedFromFavorite => 'Удалено из избранного';

  @override
  String get reset => 'Сброс';

  @override
  String get retry => 'Повторить попытку';

  @override
  String get semanticTranslation => 'Смысловой перевод';

  @override
  String get mushafPage => 'Страница мусхафа';

  @override
  String get selectThemeColor => 'Выберите цвет темы';

  @override
  String get settings => 'Настройки';

  @override
  String get surah => 'Сура';

  @override
  String get surahs => 'Суры';

  @override
  String get themeColor => 'Цвет темы';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeSystem => 'Системная';

  @override
  String get translation => 'Перевод';

  @override
  String get translationAyah => 'Перевод аята';

  @override
  String get addToFavorite => 'Добавить в избранное';

  @override
  String get removeFromFavorite => 'Удалить из избранного';

  @override
  String get jumpToPage => 'Перейти к странице';

  @override
  String get goTo => 'Перейти к...';

  @override
  String get searchAyahs => 'Поиск аятов';

  @override
  String get translationSurahName => 'Перевод названия суры';
}
