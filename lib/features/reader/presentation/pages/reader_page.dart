import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bookmarks/presentation/states/bookmarks_state.dart';
import '../../../main/states/page_number_state.dart';
import '../lists/reader_page_list.dart';

class ReaderPage extends StatelessWidget {
  final int initialPage;

  const ReaderPage({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<BookmarksState>().addLastOpenedPage(
          context.read<PageNumberState>().pageNumber,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Selector<PageNumberState, int>(
            selector: (_, s) => s.pageNumber,
            builder: (_, page, __) => Text('$page'),
          ),
          actions: [
            Selector<PageNumberState, int>(
              selector: (_, s) => s.pageNumber,
              builder: (_, page, __) => Consumer<BookmarksState>(
                builder: (context, bookmarksState, _) {
                  final isFavorite = bookmarksState.isFavoritePage(page);
                  return IconButton(
                    onPressed: () => bookmarksState.toggleFavoritePage(pageNumber: page),
                    icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
                  );
                },
              ),
            ),
          ],
        ),
        body: ReaderPageList(pageNumber: initialPage),
      ),
    );
  }
}