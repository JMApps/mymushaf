import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../main/states/page_meta_state.dart';
import '../items/favorite_page_item.dart';
import '../states/bookmarks_state.dart';

class FavoritePagesList extends StatefulWidget {
  const FavoritePagesList({super.key});

  @override
  State<FavoritePagesList> createState() => _FavoritePagesListState();
}

class _FavoritePagesListState extends State<FavoritePagesList> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;
    return Consumer2<BookmarksState, PageMetaState>(
      builder: (context, bookmarksState, pageMetaState, _) {
        if (pageMetaState.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (pageMetaState.error case final e?) {
          return Center(
            child: Padding(
              padding: AppPaddings.medium,
              child: Text(
                '$e',
                textAlign: .center,
              ),
            ),
          );
        }

        final favoritePages = pageMetaState.resolvePages(bookmarksState.favoritePageIds);

        if (favoritePages.isEmpty) {
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
            itemCount: favoritePages.length,
            itemBuilder: (context, index) {
              final pegaMetaModel = favoritePages[index];
              return FavoritePageItem(
                pageMetaModel: pegaMetaModel,
                index: index,
              );
            }
          ),
        );
      },
    );
  }
}