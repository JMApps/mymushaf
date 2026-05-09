import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/layout_entity.dart';
import '../../domain/repositories/layout_repository.dart';

class LayoutState extends ChangeNotifier {
  final LayoutRepository _layoutRepository;

  LayoutState(this._layoutRepository);

  final Map<int, List<LayoutEntity>> _pagesCache = {};
  final Map<int, Object?> _errorMap = {};
  final Set<int> _inFlight = {};

  List<LayoutEntity> getPageLayout(int pageNumber) => _pagesCache[pageNumber] ?? const [];

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
    notifyListeners();

    try {
      _pagesCache[pageNumber] = await _layoutRepository.fetchLayoutByPageNumber(pageNumber: pageNumber);
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
}