// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get alwaysDisplayOn => 'Ekran həmişə açıq';

  @override
  String get appName => 'Mənim Müshəfim';

  @override
  String get appTheme => 'Tətbiq mövzusu';

  @override
  String get arabic => 'Ərəbcə';

  @override
  String get arabicAyah => 'Ayəni ərəbcə';

  @override
  String get arabicSurahName => 'Surənin ərəbcə adı';

  @override
  String get ayah => 'Ayə';

  @override
  String get ayahs => 'Ayələr';

  @override
  String ayahsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ayə',
      many: '$count ayə',
      few: '$count ayə',
      one: '$count ayə',
    );
    return '$_temp0';
  }

  @override
  String searchResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nəticə tapıldı',
      many: '$count nəticə tapıldı',
      few: '$count nəticə tapıldı',
      one: '$count nəticə tapıldı',
      zero: 'heç nə tapılmadı',
    );
    return '$_temp0';
  }

  @override
  String searchByQuery(String query, String matches) {
    return '«$query» sorğusu üzrə↵$matches';
  }

  @override
  String get enterSearchQuery => 'Axtarmaq üçün sorğu daxil edin';

  @override
  String get searchNoResults => 'Heç nə tapılmadı';

  @override
  String searchError(String error) {
    return 'Axtarış xətası: $error';
  }

  @override
  String get ayahsTextSize => 'Ayə mətninin ölçüsü';

  @override
  String get bookmarks => 'Sevimlilər';

  @override
  String get cancel => 'Ləğv et';

  @override
  String get defaultSettings => 'Zavod parametrləri';

  @override
  String get delete => 'Sil';

  @override
  String get deleteAllBookmarks => 'Bütün sevimlileri sil';

  @override
  String get errorDbInit => 'Verilənlər bazasının işə salınması xətası';

  @override
  String get hizb => 'Hizb';

  @override
  String get hizbs => 'Hizblar';

  @override
  String get initializingData => 'Məlumatlar işə salınır…';

  @override
  String get juz => 'Cüz';

  @override
  String get juzs => 'Cüzlər';

  @override
  String get listIsEmpty => 'Siyahı boşdur';

  @override
  String get medina => 'Mədinə';

  @override
  String get mecca => 'Məkkə';

  @override
  String get page => 'Səhifə';

  @override
  String get pageShort => 'S.';

  @override
  String get pages => 'Səhifələr';

  @override
  String get recent => 'Son';

  @override
  String get removedFromFavorite => 'Sevimlilərdən silindi';

  @override
  String get reset => 'Sıfırla';

  @override
  String get retry => 'Yenidən cəhd et';

  @override
  String get semanticTranslation => 'Mənalı tərcümə';

  @override
  String get mushafPage => 'Müshəf səhifəsi';

  @override
  String get selectThemeColor => 'Mövzu rəngini seçin';

  @override
  String get settings => 'Parametrlər';

  @override
  String get surah => 'Surə';

  @override
  String get surahs => 'Surələr';

  @override
  String get themeColor => 'Mövzu rəngi';

  @override
  String get themeDark => 'Tünd';

  @override
  String get themeLight => 'Açıq';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get translation => 'Tərcümə';

  @override
  String get translationAyah => 'Ayənin tərcüməsi';

  @override
  String get addToFavorite => 'Sevimlilərə əlavə et';

  @override
  String get removeFromFavorite => 'Sevimlilərdən sil';

  @override
  String get jumpToPage => 'Səhifəyə keç';

  @override
  String get goTo => 'Keç…';

  @override
  String get searchAyahs => 'Ayələri axtar';

  @override
  String get translationSurahName => 'Surə adının tərcüməsi';
}
