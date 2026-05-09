import '../models/ayah_by_ayah_model.dart';

abstract interface class AyahByAyahLocalDataSource {
  Future<List<AyahByAyahModel>> fetchAyahsByPageNumber({required int pageNumber, required String translationColumn});

  Future<List<AyahByAyahModel>> searchAyahs({required String query, required String translationColumn});

  Future<List<AyahByAyahModel>> fetchAyahsByIds({required List<int> ayahIds, required String translationColumn});
}
