// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../core/theme/app_paddings.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../items/favorite_ayah_item.dart';
// import '../states/bookmarks_state.dart';
//
// class FavoriteAyahsList extends StatefulWidget {
//   const FavoriteAyahsList({super.key});
//
//   @override
//   State<FavoriteAyahsList> createState() => _FavoriteAyahsListState();
// }
//
// class _FavoriteAyahsListState extends State<FavoriteAyahsList> {
//   late final BookmarksState _bookmarksState;
//
//   @override
//   void initState() {
//     super.initState();
//     _bookmarksState = context.read<BookmarksState>();
//     _bookmarksState.addListener(_onFavoritesChanged);
//     Future.microtask(() => _load());
//   }
//
//   @override
//   void dispose() {
//     _bookmarksState.removeListener(_onFavoritesChanged);
//     super.dispose();
//   }
//
//   void _onFavoritesChanged() {
//     _load();
//   }
//
//   Future<void> _load() async {
//     if (!mounted) return;
//     final ayahIds = _bookmarksState.favoriteAyahIds;
//     await context.read<AyahMetaState>().syncFavoriteAyahs(
//       ayahIds: ayahIds,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appLocale = AppLocalizations.of(context);
//     final bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;
//     return Consumer<AyahMetaState>(
//       builder: (context, ayahMetaState, _) {
//         if (ayahMetaState.isLoading) {
//           return const Center(child: CircularProgressIndicator.adaptive());
//         }
//
//         if (ayahMetaState.error case final e?) {
//           return Center(
//             child: Padding(
//               padding: AppPaddings.medium,
//               child: Text(
//                 '$e',
//                 textAlign: .center,
//               ),
//             ),
//           );
//         }
//
//         final favoriteAyahsList = ayahMetaState.resolveAyahs(_bookmarksState.favoriteAyahIds);
//
//         if (favoriteAyahsList.isEmpty) {
//           return Center(
//             child: Padding(
//               padding: AppPaddings.medium,
//               child: Text(
//                 appLocale.listIsEmpty,
//                 style: AppTextStyles.medium,
//                 textAlign: .center,
//               ),
//             ),
//           );
//         }
//
//         return Scrollbar(
//           child: ListView.builder(
//             padding: EdgeInsets.only(bottom: bottomHeight),
//             itemCount: favoriteAyahsList.length,
//             itemBuilder: (context, index) {
//               final ayahByAyahModel = favoriteAyahsList[index];
//               return FavoriteAyahItem(
//                 ayahByAyahModel: ayahByAyahModel,
//                 index: index,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }