import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_device_locales.dart';
import '../../../settings/states/locale_settings_state.dart';
import '../../domain/entities/ayah_by_ayah_entity.dart';
import '../../domain/repositories/ayah_by_ayah_repository.dart';

class AyahByAyahState extends ChangeNotifier {
  final AyahByAyahRepository _ayahByAyahRepository;
  final LocaleSettingsState _localeSettingsState;

  AyahByAyahState(this._ayahByAyahRepository, this._localeSettingsState) {
    _localeSettingsState.addListener(_onSettingsChanged);
  }

  String get translationsColumn => AppDeviceLocales.ayahTranslations[_localeSettingsState.translationNameIndex].column;

  void _onSettingsChanged() {
    _pagesCache.clear();
    _errorMap.clear();
    _inFlight.clear();
    notifyListeners();
  }

  final Map<int, List<AyahByAyahEntity>> _pagesCache = {};
  final Map<int, Object?> _errorMap = {};
  final Set<int> _inFlight = {};

  List<AyahByAyahEntity> getPageAyahs(int pageNumber) => _pagesCache[pageNumber] ?? const [];

  bool isPageLoading(int pageNumber) => _inFlight.contains(pageNumber);

  bool isPageLoaded(int pageNumber) => _pagesCache.containsKey(pageNumber);

  Object? getPageError(int pageNumber) => _errorMap[pageNumber];

  Future<void> loadPage(int pageNumber) async {
    _evict(pageNumber);

    await _loadPage(pageNumber);

    if (pageNumber > 1) _loadPage(pageNumber - 1);
    if (pageNumber < AppConstants.totalMushafPageCount) _loadPage(pageNumber + 1);
  }

  Future<void> _loadPage(int pageNumber) async {
    if (_pagesCache.containsKey(pageNumber) || !_inFlight.add(pageNumber)) return;

    try {
      _pagesCache[pageNumber] = await _ayahByAyahRepository.fetchAyahsByPageNumber(
        pageNumber: pageNumber,
        translationColumn: translationsColumn,
      );
      _errorMap.remove(pageNumber);
    } catch (e) {
      _errorMap[pageNumber] = e;
    } finally {
      _inFlight.remove(pageNumber);
      notifyListeners();
    }
  }

  void _evict(int activePageNumber) {
    final keep = {
      activePageNumber,
      if (activePageNumber > 1) activePageNumber - 1,
      if (activePageNumber < AppConstants.totalMushafPageCount) activePageNumber + 1,
    };
    _pagesCache.removeWhere((page, _) => !keep.contains(page));
    _errorMap.removeWhere((page, _) => !keep.contains(page));
  }

  Future<List<AyahByAyahEntity>> searchAyahs({required String query}) {
    return _ayahByAyahRepository.searchAyahs(
      query: query,
      translationColumn: translationsColumn,
    );
  }

  @override
  void dispose() {
    _localeSettingsState.removeListener(_onSettingsChanged);
    super.dispose();
  }
}