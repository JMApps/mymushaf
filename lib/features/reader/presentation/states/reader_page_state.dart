import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_device_locales.dart';
import '../../../ayahs/domain/repositories/ayah_by_ayah_repository.dart';
import '../../../settings/states/locale_settings_state.dart';
import '../../domain/entities/reader_page_data.dart';
import '../../domain/repositories/glyph_repository.dart';
import '../../domain/repositories/layout_repository.dart';
import 'reader_page_load_state.dart';

class ReaderPageState extends ChangeNotifier {
  ReaderPageState({
    required LayoutRepository layoutRepository,
    required GlyphRepository glyphRepository,
    required AyahByAyahRepository ayahRepository,
    required LocaleSettingsState localeSettings,
  })  : _layoutRepository = layoutRepository,
        _glyphRepository = glyphRepository,
        _ayahRepository = ayahRepository,
        _localeSettingsState = localeSettings;

  final LayoutRepository _layoutRepository;
  final GlyphRepository _glyphRepository;
  final AyahByAyahRepository _ayahRepository;
  final LocaleSettingsState _localeSettingsState;

  final Map<int, ReaderPageLoadState> _pages = {};
  final Map<int, Future<void>> _runningLoads = {};

  Set<int> _activeWindow = const {};

  ReaderPageLoadState getPageState(int page) {
    return _pages[page] ?? const ReaderPageLoadState.initial();
  }

  ReaderPageData? getPageData(int page) {
    return _pages[page]?.data;
  }

  bool isPageLoaded(int page) {
    return _pages[page]?.loaded ?? false;
  }

  bool isPageLoading(int page) {
    return _pages[page]?.loading ?? false;
  }

  Object? getPageError(int page) {
    return _pages[page]?.error;
  }

  String get translationsColumn {
    final index = _localeSettingsState.translationNameIndex;
    return AppDeviceLocales.ayahTranslations[index].column;
  }

  Future<void> loadPage(int page) {
    if (!_isValidPage(page)) {
      return Future.value();
    }

    if (isPageLoaded(page)) {
      return Future.value();
    }

    final running = _runningLoads[page];
    if (running != null) {
      return running;
    }

    final future = _loadPageInternal(page);
    _runningLoads[page] = future;

    return future;
  }

  Future<void> _loadPageInternal(int page) async {
    _pages[page] = const ReaderPageLoadState.loading();

    notifyListeners();

    try {
      final translationColumn = translationsColumn;

      final layoutsFuture = _layoutRepository.fetchLayoutByPageNumber(
        pageNumber: page,
      );

      final glyphsFuture = _glyphRepository.fetchGlyphByPageNumber(
        pageNumber: page,
      );

      final ayahsFuture = _ayahRepository.fetchAyahsByPageNumber(
        pageNumber: page,
        translationColumn: translationColumn,
      );

      final layouts = await layoutsFuture;
      final glyphs = await glyphsFuture;
      final ayahs = await ayahsFuture;

      if (!_activeWindow.contains(page)) {
        return;
      }

      final data = ReaderPageData(
        pageNumber: page,
        layouts: layouts,
        glyphs: glyphs,
        ayahs: ayahs,
      );

      _pages[page] = ReaderPageLoadState.loaded(data);
    } catch (e) {
      if (_activeWindow.contains(page)) {
        _pages[page] = ReaderPageLoadState.error(e);
      }
    } finally {
      _runningLoads.remove(page);

      if (_activeWindow.contains(page)) {
        notifyListeners();
      }
    }
  }

  void loadWindow(int page) {
    if (!_isValidPage(page)) return;

    final pages = _buildWindow(page);

    _activeWindow = pages;

    _pages.removeWhere((pageNumber, _) {
      return !pages.contains(pageNumber);
    });

    _runningLoads.removeWhere((pageNumber, _) {
      return !pages.contains(pageNumber);
    });

    notifyListeners();

    for (final pageNumber in pages) {
      loadPage(pageNumber);
    }
  }

  Set<int> _buildWindow(int page) {
    final previous = page - 1;
    final next = page + 1;

    return <int>{
      if (_isValidPage(previous)) previous,
      if (_isValidPage(page)) page,
      if (_isValidPage(next)) next,
    };
  }

  bool _isValidPage(int page) {
    return page >= 1 && page <= AppConstants.totalMushafPageCount;
  }

  void clear() {
    _pages.clear();
    _runningLoads.clear();
    _activeWindow = const {};
    notifyListeners();
  }
}