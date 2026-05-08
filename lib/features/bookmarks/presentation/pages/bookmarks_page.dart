import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../lists/favorite_pages_list.dart';
import '../lists/last_favorite_pages_list.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(appLocale.bookmarks),
          actions: const [
            // CleanFavoritesButton(),
          ],
          bottom: TabBar(
            labelStyle: AppTextStyles.medium,
            splashBorderRadius: AppRadius.medium,
            tabs: [
              Tab(text: appLocale.recent),
              Tab(text: appLocale.pages),
              // Tab(text: AppStrings.ayahs),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LastFavoritePagesList(),
            FavoritePagesList(),
            //FavoriteAyahsList(),
          ],
        ),
      ),
    );
  }
}
