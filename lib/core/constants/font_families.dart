class FontFamilies {
  FontFamilies._();

  static const String ptSans = 'PT Sans';
  static const String uthmanic = 'Uthmanic';
  static const String surahHeader = 'Surah name v2';
  static const String juzName = 'Juz name';

  static String pageFont(int pageNumber) => 'p$pageNumber';

  static String glyphForSurahNumber(int surahNumber) => String.fromCharCode(0xE000 + surahNumber);
}
