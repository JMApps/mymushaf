import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../bookmarks/presentation/states/bookmarks_state.dart';
import '../../../main/states/page_meta_state.dart';
import '../../../main/states/page_number_state.dart';
import '../../../surah/presentation/states/surah_name_state.dart';
import '../states/reader_app_bar_state.dart';

class ReaderAppBar extends StatelessWidget {
  const ReaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final showAppBar = context.select<ReaderAppBarState, bool>((s) => s.showAppBar);

    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      offset: showAppBar ? Offset.zero : const Offset(0, -1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: showAppBar ? 1 : 0,
        child: IgnorePointer(
          ignoring: !showAppBar,
          child: AppBar(
            elevation: 3.5,
            titleSpacing: 0,
            title: Selector<PageNumberState, int>(
              selector: (_, s) => s.pageNumber,
              builder: (context, page, _) {
                final pageMeta = context.read<PageMetaState>().metaByPageNumber(page);
                if (pageMeta == null) return Text('$page');

                final surahName = context.read<SurahNameState>().surahByNumber(surahNumber: pageMeta.surahNumber);

                return Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(
                      '${appLocale.surah} ${surahName?.nameTranscriptionRu ?? ''}',
                      style: AppTextStyles.medium,
                    ),
                    Text(
                      '${appLocale.page} $page, ${appLocale.juz.toLowerCase()} ${pageMeta.juzNumber}',
                      style: AppTextStyles.small,
                    ),
                  ],
                );
              },
            ),
            actions: [
              Selector<PageNumberState, int>(
                selector: (_, s) => s.pageNumber,
                builder: (_, page, _) => Consumer<BookmarksState>(
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
        ),
      ),
    );
  }
}