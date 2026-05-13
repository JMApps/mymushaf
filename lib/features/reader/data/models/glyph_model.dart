import '../../../../core/database/constants/column_names.dart';

class GlyphModel {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final int wordNumber;
  final String glyph;
  final String word;

  const GlyphModel({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.wordNumber,
    required this.glyph,
    required this.word,
  });

  factory GlyphModel.fromMap(Map<String, Object?> map) {
    return GlyphModel(
      id: map[ColumnNames.id] as int,
      surahNumber: map[ColumnNames.surahNumber] as int,
      ayahNumber: map[ColumnNames.ayahNumber] as int,
      wordNumber: map[ColumnNames.wordNumber] as int,
      glyph: map[ColumnNames.glyph] as String,
      word: map[ColumnNames.word] as String,
    );
  }
}
