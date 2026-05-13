import '../entities/glyph_entity.dart';

abstract interface class GlyphRepository {
  Future<List<GlyphEntity>> fetchGlyphByPageNumber({required int pageNumber});
}