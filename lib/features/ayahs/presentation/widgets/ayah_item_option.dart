import 'package:flutter/material.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../bookmarks/presentation/states/bookmarks_state.dart';
import '../../../reader/domain/entities/mushaf_page_row_entity.dart';
import '../../../surah/presentation/states/surah_name_state.dart';

class AyahItemOption extends StatelessWidget {
  const AyahItemOption({
    super.key,
    required this.mushafPageRowModel,
    required this.verseKey,
    required this.ayahIndex,
  });

  final MushafPageRowEntity mushafPageRowModel;
  final String verseKey;
  final int ayahIndex;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final appLocale = AppLocalizations.of(context);
    final surahFirstVerseKey = context.select<SurahNameState, String?>((s) => s.surahByVerseKey(appLocale.surah, verseKey, appLocale.ayah.toLowerCase()));
    final wholeAyah = '${mushafPageRowModel.arabicAyah}\n\n${mushafPageRowModel.translation}\n\n$surahFirstVerseKey';
    return Padding(
      padding: AppPaddings.withoutTopMedium,
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: [
          Container(
            height: 50,
            padding: AppPaddings.small,
            alignment: .center,
            decoration: BoxDecoration(
              color: appColors.secondaryContainer.withAlpha(155),
              borderRadius: AppRadius.small,
            ),
            child: Text(verseKey),
          ),

          Selector<BookmarksState, bool>(
            selector: (_, state) => state.isFavoriteAyah(mushafPageRowModel.ayahId!),
            builder: (context, isFavorite, child) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<BookmarksState>().toggleFavoriteAyah(
                    ayahId: mushafPageRowModel.ayahId!,
                  );
                },
                icon: Icon(isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                ),
              );
            },
          ),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Pasteboard.writeText(wholeAyah);
            },
            icon: const Icon(Icons.copy_rounded),
          ),

          IconButton(
            onPressed: () async{
              Navigator.pop(context);
              await SharePlus.instance.share(
                ShareParams(
                  text: wholeAyah,
                  sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 1),
                ),
              );
            },
            icon: const Icon(Icons.ios_share),
          ),
        ],
      ),
    );
  }
}