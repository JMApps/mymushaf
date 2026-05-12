import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../ayahs/domain/entities/ayah_by_ayah_entity.dart';
import '../../../ayahs/presentation/states/ayah_by_ayah_state.dart';
import '../items/favorite_ayah_item.dart';
import '../states/bookmarks_state.dart';

class FavoriteAyahsList extends StatefulWidget {
  const FavoriteAyahsList({super.key});

  @override
  State<FavoriteAyahsList> createState() => _FavoriteAyahsListState();
}

class _FavoriteAyahsListState extends State<FavoriteAyahsList> {
  late final BookmarksState _bookmarksState;

  @override
  void initState() {
    super.initState();
    _bookmarksState = context.read<BookmarksState>();
    _bookmarksState.addListener(_onFavoritesChanged);
    _load();
  }

  @override
  void dispose() {
    _bookmarksState.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() => _load();

  void _load() {
    if (!mounted) return;
    context.read<AyahByAyahState>().loadFavoriteAyahs(_bookmarksState.favoriteAyahIds);
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;
    return Selector<AyahByAyahState, ({bool loading, Object? error, List<AyahByAyahEntity> ayahs})>(
      selector: (_, s) => (
      loading: s.isFavoritesLoading,
      error: s.favoritesError,
      ayahs: s.favoriteAyahs,
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

        if (state.ayahs.isEmpty) {
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
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: bottomHeight),
            itemCount: state.ayahs.length,
            itemBuilder: (context, index) => FavoriteAyahItem(
              ayahByAyahModel: state.ayahs[index],
              index: index,
            ),
          ),
        );
      },
    );
  }
}