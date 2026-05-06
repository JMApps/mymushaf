import 'package:flutter/material.dart';

import '../../domain/entities/surah_name_entity.dart';
import '../../domain/repositories/surah_name_repository.dart';

class SurahNameState extends ChangeNotifier {
  final SurahNameRepository _surahNameRepository;

  SurahNameState(this._surahNameRepository) {
    _loadAllSurahs();
  }

  List<SurahNameEntity> _surahs = const [];

  bool _isLoading = false;
  Object? _error;

  List<SurahNameEntity> get surahs => _surahs;

  bool get isLoading => _isLoading;

  Object? get error => _error;

  String surahByVerseKey(String firstVerseKey, String ayahTitle) {
    final parts = firstVerseKey.split(':');
    final surahId = int.parse(parts[0]);
    final ayah = parts[1];
    final surah = _surahs[surahId - 1];
    return '${surah.nameTranscriptionRu}, $ayahTitle $ayah';
  }

  Future<void> _loadAllSurahs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _surahs = await _surahNameRepository.fetchAllSurahs();
      _error = null;
    } catch (e, s) {
      _error = e;
      debugPrint('$e\n$s');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
