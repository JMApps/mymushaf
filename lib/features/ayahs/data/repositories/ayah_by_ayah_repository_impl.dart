import '../../domain/entities/ayah_by_ayah_entity.dart';
import '../../domain/repositories/ayah_by_ayah_repository.dart';
import '../data_sources/ayah_by_ayah_data_source.dart';
import '../mappers/ayah_by_ayah_mapper.dart';

class AyahByAyahRepositoryImpl implements AyahByAyahRepository {
  final AyahByAyahLocalDataSource _dataSource;

  const AyahByAyahRepositoryImpl(this._dataSource);

  @override
  Future<List<AyahByAyahEntity>> fetchAyahsByPageNumber({required int pageNumber, required String translationColumn}) async {
    final models = await _dataSource.fetchAyahsByPageNumber(pageNumber: pageNumber, translationColumn: translationColumn);
    return models.map((m) => m.toEntity()).toList(growable: false);
  }

  @override
  Future<List<AyahByAyahEntity>> searchAyahs({required String query, required String translationColumn}) async {
    final models = await _dataSource.searchAyahs(query: query, translationColumn: translationColumn);
    return models.map((m) => m.toEntity()).toList(growable: false);
  }

  @override
  Future<List<AyahByAyahEntity>> fetchAyahsByIds({required List<int> ayahIds, required String translationColumn}) async {
    final models = await _dataSource.fetchAyahsByIds(ayahIds: ayahIds, translationColumn: translationColumn);
    return models.map((m) => m.toEntity()).toList(growable: false);
  }
}