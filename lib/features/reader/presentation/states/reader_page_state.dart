import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_device_locales.dart';
import '../../../ayahs/domain/repositories/ayah_by_ayah_repository.dart';
import '../../../settings/states/locale_settings_state.dart';
import '../../domain/entities/reader_page_data.dart';
import '../../domain/repositories/glyph_repository.dart';
import '../../domain/repositories/layout_repository.dart';
import 'reader_page_load_state.dart';

class ReaderPageState extends ChangeNotifier {
  final LayoutRepository _layoutRepository;
  final GlyphRepository _glyphRepository;
  final AyahByAyahRepository _ayahRepository;
  final LocaleSettingsState _localeSettingsState;

  ReaderPageState({
    required LayoutRepository layoutRepository,
    required GlyphRepository glyphRepository,
    required AyahByAyahRepository ayahRepository,
    required LocaleSettingsState localeSettings,
  })  : _layoutRepository = layoutRepository, _glyphRepository = glyphRepository, _ayahRepository = ayahRepository, _localeSettingsState = localeSettings;

  final Map<int, ReaderPageLoadState> _pages = {};
  final Map<int, Future<void>> _runningLoads = {};

  ReaderPageLoadState getPageState(int page) {
    return _pages[page] ?? const ReaderPageLoadState.initial();
  }

  String get translationsColumn {
    return AppDeviceLocales.ayahTranslations[_localeSettingsState.translationNameIndex].column;
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

  Future<void> loadPage(int page) {
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
    try {
      final layoutsFuture = _layoutRepository.fetchLayoutByPageNumber(pageNumber: page);
      final glyphsFuture = _glyphRepository.fetchGlyphByPageNumber(pageNumber: page);
      final ayahsFuture = _ayahRepository.fetchAyahsByPageNumber(pageNumber: page, translationColumn: translationsColumn);

      final layouts = await layoutsFuture;
      final glyphs = await glyphsFuture;
      final ayahs = await ayahsFuture;

      final data = ReaderPageData(
        pageNumber: page,
        layouts: layouts,
        glyphs: glyphs,
        ayahs: ayahs,
      );

      _pages[page] = ReaderPageLoadState.loaded(data);
    } catch (e) {
      _pages[page] = ReaderPageLoadState.error(e);
    } finally {
      _runningLoads.remove(page);
      notifyListeners();
    }
  }

  void loadWindow(int page, int totalPages) {
    final pages = <int>{};

    final previous = page - 1;
    final next = page + 1;

    if (previous >= 1) pages.add(previous);
    if (page >= 1 && page <= totalPages) pages.add(page);
    if (next <= totalPages) pages.add(next);

    for (final p in pages) {
      loadPage(p);
    }

    keepOnlyPages(pages);
  }

  void keepOnlyPages(Set<int> pages) {
    _pages.removeWhere((page, _) => !pages.contains(page));
    _runningLoads.removeWhere((page, _) => !pages.contains(page));
  }

  void clear() {
    _pages.clear();
    _runningLoads.clear();
    notifyListeners();
  }
}