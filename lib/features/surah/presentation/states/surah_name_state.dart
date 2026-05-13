import 'package:flutter/material.dart';

import '../../domain/entities/surah_name_entity.dart';
import '../../domain/repositories/surah_name_repository.dart';

class SurahNameState extends ChangeNotifier {
  SurahNameState(this._surahNameRepository) {
    _loadAllSurahs();
  }

  final SurahNameRepository _surahNameRepository;

  List<SurahNameEntity> _surahs = const [];
  bool _isLoading = false;
  Object? _error;

  List<SurahNameEntity> get surahs => _surahs;
  bool get isLoading => _isLoading;
  Object? get error => _error;
  bool get isReady => _surahs.isNotEmpty && !_isLoading;

  String? surahByVerseKey(String firstVerseKey, String ayahTitle) {
    final parts = firstVerseKey.split(':');

    if (parts.length != 2) return null;

    final surahId = int.tryParse(parts[0]);
    if (surahId == null) return null;

    final index = surahId - 1;
    if (index < 0 || index >= _surahs.length) return null;

    final ayah = parts[1];
    final surah = _surahs[index];

    return '${surah.nameTranscriptionRu}, $ayahTitle $ayah';
  }

  SurahNameEntity? surahByNumber({required int surahNumber}) {
    final index = surahNumber - 1;

    if (index < 0 || index >= _surahs.length) return null;

    return _surahs[index];
  }

  Future<void> _loadAllSurahs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _surahs = await _surahNameRepository.fetchAllSurahs();
    } catch (e, s) {
      _error = e;
      debugPrint('$e\n$s');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}