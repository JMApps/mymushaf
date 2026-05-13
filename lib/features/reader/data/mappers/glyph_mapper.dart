import '../../domain/entities/glyph_entity.dart';
import '../models/glyph_model.dart';

extension GlyphMapper on GlyphModel {
  GlyphEntity glyphToEntity() {
    return GlyphEntity(
      id: id,
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      wordNumber: wordNumber,
      glyph: glyph,
      word: word,
    );
  }
}
