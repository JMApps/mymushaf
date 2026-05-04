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
  String get errorDbInit => 'Database initialization error';

  @override
  String get retry => 'Try again';

  @override
  String get surah => 'Surah';

  @override
  String get juz => 'Juz';

  @override
  String get hizb => 'Hizb';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get settings => 'Settings';
}
