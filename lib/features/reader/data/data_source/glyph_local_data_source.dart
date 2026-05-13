import '../models/glyph_model.dart';

abstract interface class GlyphLocalDataSource {
  Future<List<GlyphModel>> fetchGlyphByPageNumber({required int pageNumber});
}