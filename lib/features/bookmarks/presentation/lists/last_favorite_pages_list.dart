import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../main/states/page_meta_state.dart';
import '../items/last_favorite_page_item.dart';
import '../states/bookmarks_state.dart';

class LastFavoritePagesList extends StatefulWidget {
  const LastFavoritePagesList({super.key});

  @override
  State<LastFavoritePagesList> createState() => _LastFavoritePagesListState();
}

class _LastFavoritePagesListState extends State<LastFavoritePagesList> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;

    return Selector2<BookmarksState, PageMetaState, ({bool loading, Object? error, List pageMetas})>(
      selector: (_, bookmarksState, pageMetaState) => (
      loading: pageMetaState.isLoading,
      error: pageMetaState.error,
      pageMetas: pageMetaState.resolvePages(bookmarksState.lastPageIds),
      ),
      builder: (context, state, _) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.error case final e?) {
          return Center(
            child: Padding(
              padding: AppPaddings.medium,
              child: Text('$e', textAlign: .center),
            ),
          );
        }

        if (state.pageMetas.isEmpty) {
          return Center(
            child: Padding(
              padding: AppPaddings.medium,
              child: Text(
                appLocale.listIsEmpty,
                style: AppTextStyles.medium,
                textAlign: .center,
              ),
            ),
          );
        }

        return Scrollbar(
          controller: _controller,
          child: ListView.builder(
            controller: _controller,
            padding: EdgeInsets.only(bottom: bottomHeight),
            itemCount: state.pageMetas.length,
            itemBuilder: (context, index) {
              final pageMetaModel = state.pageMetas[index];
              return LastFavoritePageItem(
                pageMetaModel: pageMetaModel,
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}