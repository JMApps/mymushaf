import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @alwaysDisplayOn.
  ///
  /// In ru, this message translates to:
  /// **'Дисплей всегда включён'**
  String get alwaysDisplayOn;

  /// No description provided for @appName.
  ///
  /// In ru, this message translates to:
  /// **'Мой Мусхаф'**
  String get appName;

  /// No description provided for @appTheme.
  ///
  /// In ru, this message translates to:
  /// **'Тема приложения'**
  String get appTheme;

  /// No description provided for @arabic.
  ///
  /// In ru, this message translates to:
  /// **'Арабский'**
  String get arabic;

  /// No description provided for @arabicAyah.
  ///
  /// In ru, this message translates to:
  /// **'Аят на арабском'**
  String get arabicAyah;

  /// No description provided for @arabicSurahName.
  ///
  /// In ru, this message translates to:
  /// **'Название суры на арабском'**
  String get arabicSurahName;

  /// No description provided for @ayah.
  ///
  /// In ru, this message translates to:
  /// **'Аят'**
  String get ayah;

  /// No description provided for @ayahs.
  ///
  /// In ru, this message translates to:
  /// **'Аяты'**
  String get ayahs;

  /// No description provided for @ayahsCount.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{{count} аят} few{{count} аята} many{{count} аятов} other{{count} аята}}'**
  String ayahsCount(int count);

  /// No description provided for @searchResults.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =0{ничего не найдено} one{найден {count} результат} few{найдено {count} результата} many{найдено {count} результатов} other{Найдено {count} результата}}'**
  String searchResults(int count);

  /// No description provided for @searchByQuery.
  ///
  /// In ru, this message translates to:
  /// **'По запросу «{query}» {matches}'**
  String searchByQuery(String query, String matches);

  /// No description provided for @enterSearchQuery.
  ///
  /// In ru, this message translates to:
  /// **'Введите запрос для поиска'**
  String get enterSearchQuery;

  /// No description provided for @searchNoResults.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get searchNoResults;

  /// No description provided for @searchError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка поиска: {error}'**
  String searchError(String error);

  /// No description provided for @ayahsTextSize.
  ///
  /// In ru, this message translates to:
  /// **'Размер текста аята'**
  String get ayahsTextSize;

  /// No description provided for @bookmarks.
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get bookmarks;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @defaultSettings.
  ///
  /// In ru, this message translates to:
  /// **'Заводские настройки'**
  String get defaultSettings;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @deleteAllBookmarks.
  ///
  /// In ru, this message translates to:
  /// **'Удалить всё избранное'**
  String get deleteAllBookmarks;

  /// No description provided for @errorDbInit.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка инициализации базы данных'**
  String get errorDbInit;

  /// No description provided for @hizb.
  ///
  /// In ru, this message translates to:
  /// **'Хизб'**
  String get hizb;

  /// No description provided for @hizbs.
  ///
  /// In ru, this message translates to:
  /// **'Хизбы'**
  String get hizbs;

  /// No description provided for @initializingData.
  ///
  /// In ru, this message translates to:
  /// **'Инициализация данных…'**
  String get initializingData;

  /// No description provided for @juz.
  ///
  /// In ru, this message translates to:
  /// **'Джуз'**
  String get juz;

  /// No description provided for @juzs.
  ///
  /// In ru, this message translates to:
  /// **'Джузы'**
  String get juzs;

  /// No description provided for @listIsEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Список пуст'**
  String get listIsEmpty;

  /// No description provided for @medina.
  ///
  /// In ru, this message translates to:
  /// **'Медина'**
  String get medina;

  /// No description provided for @mecca.
  ///
  /// In ru, this message translates to:
  /// **'Мекка'**
  String get mecca;

  /// No description provided for @page.
  ///
  /// In ru, this message translates to:
  /// **'Страница'**
  String get page;

  /// No description provided for @pageShort.
  ///
  /// In ru, this message translates to:
  /// **'Стр.'**
  String get pageShort;

  /// No description provided for @pages.
  ///
  /// In ru, this message translates to:
  /// **'Страницы'**
  String get pages;

  /// No description provided for @recent.
  ///
  /// In ru, this message translates to:
  /// **'Последние'**
  String get recent;

  /// No description provided for @removedFromFavorite.
  ///
  /// In ru, this message translates to:
  /// **'Удалено из избранного'**
  String get removedFromFavorite;

  /// No description provided for @reset.
  ///
  /// In ru, this message translates to:
  /// **'Сброс'**
  String get reset;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить попытку'**
  String get retry;

  /// No description provided for @semanticTranslation.
  ///
  /// In ru, this message translates to:
  /// **'Смысловой перевод'**
  String get semanticTranslation;

  /// No description provided for @mushafPage.
  ///
  /// In ru, this message translates to:
  /// **'Страница мусхафа'**
  String get mushafPage;

  /// No description provided for @selectThemeColor.
  ///
  /// In ru, this message translates to:
  /// **'Выберите цвет темы'**
  String get selectThemeColor;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @surah.
  ///
  /// In ru, this message translates to:
  /// **'Сура'**
  String get surah;

  /// No description provided for @surahs.
  ///
  /// In ru, this message translates to:
  /// **'Суры'**
  String get surahs;

  /// No description provided for @themeColor.
  ///
  /// In ru, this message translates to:
  /// **'Цвет темы'**
  String get themeColor;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @translation.
  ///
  /// In ru, this message translates to:
  /// **'Перевод'**
  String get translation;

  /// No description provided for @translationAyah.
  ///
  /// In ru, this message translates to:
  /// **'Перевод аята'**
  String get translationAyah;

  /// No description provided for @addToFavorite.
  ///
  /// In ru, this message translates to:
  /// **'Добавить в избранное'**
  String get addToFavorite;

  /// No description provided for @removeFromFavorite.
  ///
  /// In ru, this message translates to:
  /// **'Удалить из избранного'**
  String get removeFromFavorite;

  /// No description provided for @jumpToPage.
  ///
  /// In ru, this message translates to:
  /// **'Перейти к странице'**
  String get jumpToPage;

  /// No description provided for @goTo.
  ///
  /// In ru, this message translates to:
  /// **'Перейти к...'**
  String get goTo;

  /// No description provided for @searchAyahs.
  ///
  /// In ru, this message translates to:
  /// **'Поиск аятов'**
  String get searchAyahs;

  /// No description provided for @translationSurahName.
  ///
  /// In ru, this message translates to:
  /// **'Перевод названия суры'**
  String get translationSurahName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
