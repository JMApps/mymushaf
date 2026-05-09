import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../main/states/page_number_state.dart';
import '../items/read_item.dart';
import '../states/layout_state.dart';

class ReaderPageList extends StatefulWidget {
  final int pageNumber;

  const ReaderPageList({super.key, required this.pageNumber});

  @override
  State<ReaderPageList> createState() => _ReaderPageListState();
}

class _ReaderPageListState extends State<ReaderPageList> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.pageNumber - 1);
    context.read<LayoutState>().loadPage(widget.pageNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      reverse: true,
      itemCount: AppConstants.totalMushafPageCount,
      onPageChanged: (index) {
        final page = index + 1;
        context.read<PageNumberState>().setPageNumber(page);
        context.read<LayoutState>().loadPage(page);
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
              layouts: context.read<LayoutState>().getPageLayout(page),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}