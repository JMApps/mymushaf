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
}
