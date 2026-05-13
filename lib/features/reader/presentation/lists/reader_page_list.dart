import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../bookmarks/presentation/states/bookmarks_state.dart';
import '../../../main/states/page_number_state.dart';
import '../items/read_item.dart';
import '../states/reader_page_load_state.dart';
import '../states/reader_page_state.dart';

class ReaderPageList extends StatefulWidget {
  final int pageNumber;
  final PageController pageController;

  const ReaderPageList({
    super.key,
    required this.pageNumber,
    required this.pageController,
  });

  @override
  State<ReaderPageList> createState() => _ReaderPageListState();
}

class _ReaderPageListState extends State<ReaderPageList> with WidgetsBindingObserver {
  late final PageNumberState _pageNumberState;
  late final ReaderPageState _readerPageState;
  late final BookmarksState _bookmarksState;

  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _pageNumberState = context.read<PageNumberState>();
    _readerPageState = context.read<ReaderPageState>();
    _bookmarksState = context.read<BookmarksState>();
    WidgetsBinding.instance.addObserver(this);
    _currentPage = widget.pageNumber;
    _readerPageState.loadWindow(_currentPage);
  }

  @override
  void didUpdateWidget(covariant ReaderPageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageNumber != widget.pageNumber) {
      _currentPage = widget.pageNumber;
      _readerPageState.loadWindow(_currentPage);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _bookmarksState.addLastOpenedPage(_pageNumberState.pageNumber);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bookmarksState.addLastOpenedPage(_pageNumberState.pageNumber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      reverse: true,
      allowImplicitScrolling: false,
      itemCount: AppConstants.totalMushafPageCount,
      onPageChanged: (int index) {
        final page = index + 1;
        if (_currentPage == page) return;
        _currentPage = page;
        _pageNumberState.setPageNumber(page);
        _readerPageState.loadWindow(page);
      },
      itemBuilder: (context, index) {
        final page = index + 1;

        return Selector<ReaderPageState, ReaderPageLoadState>(
          selector: (_, state) => state.getPageState(page),
          builder: (context, state, _) {
            if (state.error != null) {
              return Padding(
                padding: AppPaddings.medium,
                child: Center(
                  child: Text('${state.error}'),
                ),
              );
            }

            if (state.loading || !state.loaded) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            final data = state.data!;

            return ReadItem(
              pageNumber: page,
              layouts: data.layouts,
              glyphs: data.glyphs,
              ayahs: data.ayahs,
            );
          },
        );
      },
    );
  }
}
