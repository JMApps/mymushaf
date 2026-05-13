import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../ayahs/presentation/states/ayah_by_ayah_state.dart';
import '../../../bookmarks/presentation/states/bookmarks_state.dart';
import '../../../main/states/page_number_state.dart';
import '../items/read_item.dart';
import '../states/glyph_state.dart';
import '../states/layout_state.dart';

class ReaderPageList extends StatefulWidget {
  final int pageNumber;

  const ReaderPageList({super.key, required this.pageNumber});

  @override
  State<ReaderPageList> createState() => _ReaderPageListState();
}

class _ReaderPageListState extends State<ReaderPageList> with WidgetsBindingObserver {
  late final PageController _controller;
  late final LayoutState _layoutState;
  late final GlyphState _glyphState;
  late final AyahByAyahState _ayahState;
  late final PageNumberState _pageNumberState;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.pageNumber - 1);
    _layoutState = context.read<LayoutState>();
    _glyphState = context.read<GlyphState>();
    _ayahState = context.read<AyahByAyahState>();
    _pageNumberState = context.read<PageNumberState>();
    WidgetsBinding.instance.addObserver(this);
    _loadAll(widget.pageNumber);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      context.read<BookmarksState>().addLastOpenedPage(_pageNumberState.pageNumber);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void _loadAll(int page) {
    _layoutState.loadPage(page);
    _glyphState.loadPage(page);
    _ayahState.loadPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      reverse: true,
      allowImplicitScrolling: false,
      itemCount: AppConstants.totalMushafPageCount,
      onPageChanged: (index) {
        final page = index + 1;
        _pageNumberState.setPageNumber(page);
        _loadAll(page);
      },
      itemBuilder: (context, index) {
        final page = index + 1;

        return Selector<LayoutState, ({bool loading, Object? error, bool loaded})>(
          selector: (_, s) => (
          loading: s.isPageLoading(page),
          error: s.getPageError(page),
          loaded: s.isPageLoaded(page),
          ),
          builder: (context, state, _) => switch (state) {
            (loading: true, error: _, loaded: _) => const Center(child: CircularProgressIndicator.adaptive()),
            (loading: _, error: final e?, loaded: _) => Padding(
              padding: AppPaddings.medium,
              child: Center(child: Text('$e')),
            ),
            (loading: _, error: _, loaded: true) => ReadItem(
              pageNumber: page,
              layouts: _layoutState.getPageLayout(page),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}