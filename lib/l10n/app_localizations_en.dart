// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'My Mushaf';

  @override
  String get initializingData => 'Setting things up…';

  @override
  String get errorDbInit => 'Couldn\'t initialize the database';

  @override
  String get retry => 'Try again';

  @override
  String get surah => 'Surah';

  @override
  String get surahs => 'Surahs';

  @override
  String get ayahs => 'Ayahs';

  @override
  String get ayah => 'Ayah';

  @override
  String get juz => 'Juz';

  @override
  String get juzs => 'Juzs';

  @override
  String get hizb => 'Hizb';

  @override
  String get hizbs => 'Hizbs';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get settings => 'Settings';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAllBookmarks => 'Delete all bookmarks';

  @override
  String get listIsEmpty => 'List is empty';

  @override
  String get pageShort => 'p.';

  @override
  String get recent => 'Recent';

  @override
  String get pages => 'Pages';

  @override
  String get cancel => 'Cancel';

  @override
  String get page => 'Page';

  @override
  String get removedFromFavorite => 'Удалено из изборанного';

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
  String get mecca => 'Mecca';

  @override
  String get medina => 'Medina';
}
