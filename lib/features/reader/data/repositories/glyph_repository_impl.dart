import '../../domain/entities/glyph_entity.dart';
import '../../domain/repositories/glyph_repository.dart';
import '../data_source/glyph_local_data_source.dart';
import '../mappers/glyph_mapper.dart';

class GlyphRepositoryImpl implements GlyphRepository {
  final GlyphLocalDataSource _localDataSource;

  const GlyphRepositoryImpl(this._localDataSource);

  @override
  Future<List<GlyphEntity>> fetchGlyphByPageNumber({required int pageNumber}) async {
    final glyphsByPageNumber = await _localDataSource.fetchGlyphByPageNumber(pageNumber: pageNumber);
    return glyphsByPageNumber.map((m) => m.glyphToEntity()).toList();
  }
}