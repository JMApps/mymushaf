import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_device_locales.dart';
import '../../../settings/states/locale_settings_state.dart';
import '../../domain/entities/ayah_by_ayah_entity.dart';
import '../../domain/repositories/ayah_by_ayah_repository.dart';

class AyahByAyahState extends ChangeNotifier {
  AyahByAyahState(this._ayahByAyahRepository, this._localeSettingsState) {
    _localeSettingsState.addListener(_onSettingsChanged);
  }

  final AyahByAyahRepository _ayahByAyahRepository;
  final LocaleSettingsState _localeSettingsState;

  final Map<int, List<AyahByAyahEntity>> _pagesCache = {};
  final Map<int, Object?> _errorMap = {};
  final Set<int> _inFlight = {};

  Set<int> _activeWindow = const {};
  int _generation = 0;

  List<AyahByAyahEntity> _favoriteAyahs = const [];
  bool _isFavoritesLoading = false;
  Object? _favoritesError;

  String get translationsColumn {
    return AppDeviceLocales.ayahTranslations[_localeSettingsState.translationNameIndex].column;
  }

  List<AyahByAyahEntity> getPageAyahs(int pageNumber) {
    return _pagesCache[pageNumber] ?? const [];
  }

  bool isPageLoading(int pageNumber) => _inFlight.contains(pageNumber);

  bool isPageLoaded(int pageNumber) => _pagesCache.containsKey(pageNumber);

  Object? getPageError(int pageNumber) => _errorMap[pageNumber];

  List<AyahByAyahEntity> get favoriteAyahs => _favoriteAyahs;

  bool get isFavoritesLoading => _isFavoritesLoading;

  Object? get favoritesError => _favoritesError;

  Future<void> loadPage(int pageNumber) async {
    if (!_isValidPage(pageNumber)) return;

    _generation++;
    final generation = _generation;

    _activeWindow = _buildWindow(pageNumber);
    _evictOutsideActiveWindow();

    await _loadPage(pageNumber, generation);

    final previous = pageNumber - 1;
    final next = pageNumber + 1;

    if (_activeWindow.contains(previous)) {
      unawaitedLoad(previous, generation);
    }

    if (_activeWindow.contains(next)) {
      unawaitedLoad(next, generation);
    }
  }

  void unawaitedLoad(int pageNumber, int generation) {
    _loadPage(pageNumber, generation);
  }

  Future<void> _loadPage(int pageNumber, int generation) async {
    if (!_activeWindow.contains(pageNumber)) return;
    if (_pagesCache.containsKey(pageNumber)) return;
    if (!_inFlight.add(pageNumber)) return;

    final column = translationsColumn;

    try {
      final result = await _ayahByAyahRepository.fetchAyahsByPageNumber(
        pageNumber: pageNumber,
        translationColumn: column,
      );

      if (generation != _generation) return;
      if (!_activeWindow.contains(pageNumber)) return;

      _pagesCache[pageNumber] = result;
      _errorMap.remove(pageNumber);
    } catch (e) {
      if (generation != _generation) return;
      if (!_activeWindow.contains(pageNumber)) return;

      _errorMap[pageNumber] = e;
    } finally {
      _inFlight.remove(pageNumber);
      _evictOutsideActiveWindow();
      notifyListeners();
    }
  }

  Future<void> loadFavoriteAyahs(List<int> ayahIds) async {
    final generation = _generation;
    if (ayahIds.isEmpty) {
      _favoriteAyahs = const [];
      _favoritesError = null;
      return;
    }

    _isFavoritesLoading = true;
    _favoritesError = null;

    final column = translationsColumn;

    try {
      final result = await _ayahByAyahRepository.fetchAyahsByIds(
        ayahIds: ayahIds,
        translationColumn: column,
      );

      if (generation != _generation) return;

      _favoriteAyahs = result;
    } catch (e) {
      if (generation != _generation) return;

      _favoritesError = e;
    } finally {
      if (generation == _generation) {
        _isFavoritesLoading = false;
        notifyListeners();
      }
    }
  }

  Future<List<AyahByAyahEntity>> searchAyahs({required String query}) {
    return _ayahByAyahRepository.searchAyahs(
      query: query,
      translationColumn: translationsColumn,
    );
  }

  void _onSettingsChanged() {
    _generation++;
    _pagesCache.clear();
    _errorMap.clear();
    _inFlight.clear();
    _favoriteAyahs = const [];
    _favoritesError = null;
    _isFavoritesLoading = false;
    notifyListeners();
  }

  Set<int> _buildWindow(int activePageNumber) {
    return {
      activePageNumber,
      if (activePageNumber > 1) activePageNumber - 1,
      if (activePageNumber < AppConstants.totalMushafPageCount)
        activePageNumber + 1,
    };
  }

  void _evictOutsideActiveWindow() {
    _pagesCache.removeWhere((page, _) => !_activeWindow.contains(page));
    _errorMap.removeWhere((page, _) => !_activeWindow.contains(page));
    _inFlight.removeWhere((page) => !_activeWindow.contains(page));
  }

  bool _isValidPage(int pageNumber) {
    return pageNumber >= 1 && pageNumber <= AppConstants.totalMushafPageCount;
  }

  @override
  void dispose() {
    _localeSettingsState.removeListener(_onSettingsChanged);
    super.dispose();
  }
}