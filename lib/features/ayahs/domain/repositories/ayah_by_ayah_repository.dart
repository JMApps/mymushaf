import '../entities/ayah_by_ayah_entity.dart';

abstract interface class AyahByAyahRepository {
  Future<List<AyahByAyahEntity>> fetchAyahsByPageNumber({required int pageNumber, required String translationColumn});

  Future<List<AyahByAyahEntity>> searchAyahs({required String query, required String translationColumn});

  Future<List<AyahByAyahEntity>> fetchAyahsByIds({required List<int> ayahIds, required String translationColumn});
}
