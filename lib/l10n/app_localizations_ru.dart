// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Мой Мусхаф';

  @override
  String get initializingData => 'Инициализация данных…';

  @override
  String get errorDbInit => 'Ошибка инициализации базы данных';

  @override
  String get retry => 'Повторить попытку';

  @override
  String get surah => 'Сура';

  @override
  String get surahs => 'Суры';

  @override
  String get ayahs => 'Аяты';

  @override
  String get ayah => 'Аят';

  @override
  String get juz => 'Джузы';

  @override
  String get hizb => 'Хизб';

  @override
  String get hizbs => 'Хизбы';

  @override
  String get bookmarks => 'Избранное';

  @override
  String get settings => 'Настройки';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteAllBookmarks => 'Удалить все избранное';

  @override
  String get listIsEmpty => 'Список пуст';

  @override
  String get pageShort => 'Стр.';

  @override
  String get recent => 'Последние';

  @override
  String get pages => 'Страницы';

  @override
  String get cancel => 'Отмена';

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
  String get mecca => 'Мекка';

  @override
  String get medina => 'Медина';
}
