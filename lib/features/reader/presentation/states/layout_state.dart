import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/layout_entity.dart';
import '../../domain/repositories/layout_repository.dart';

class LayoutState extends ChangeNotifier {
  LayoutState(this._layoutRepository);

  final LayoutRepository _layoutRepository;

  final Map<int, List<LayoutEntity>> _pagesCache = {};
  final Map<int, Object?> _errorMap = {};
  final Set<int> _inFlight = {};

  Set<int> _activeWindow = const {};
  int _generation = 0;

  List<LayoutEntity> getPageLayout(int pageNumber) {
    return _pagesCache[pageNumber] ?? const [];
  }

  bool isPageLoading(int pageNumber) => _inFlight.contains(pageNumber);

  bool isPageLoaded(int pageNumber) => _pagesCache.containsKey(pageNumber);

  Object? getPageError(int pageNumber) => _errorMap[pageNumber];

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
    try {
      final result = await _layoutRepository.fetchLayoutByPageNumber(
        pageNumber: pageNumber,
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

  Set<int> _buildWindow(int activePageNumber) {
    return {
      activePageNumber, if (activePageNumber > 1) activePageNumber - 1,
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
}