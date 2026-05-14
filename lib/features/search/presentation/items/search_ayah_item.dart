import 'package:flutter/material.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../ayahs/domain/entities/ayah_by_ayah_entity.dart';
import '../widgets/ayah_info_text.dart';
import '../widgets/highlighted_ayah_text.dart';

/// Элемент списка результатов поиска аятов
class SearchAyahItem extends StatelessWidget {
  const SearchAyahItem({
    super.key,
    required this.ayah,
    required this.index,
    required this.query,
  });

  final AyahByAyahEntity ayah;
  final int index;
  final String query;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      onLongPress: () {},
      child: Container(
        padding: AppPaddings.medium,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.25,
              color: appColors.outlineVariant,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            HighlightedAyahText(
              text: ayah.ayahArabic,
              query: query,
              isArabic: true,
            ),
            const SizedBox(height: AppSpacing.medium),
            HighlightedAyahText(
              text: ayah.ayahTranslation,
              query: query,
              isArabic: false,
            ),
            const SizedBox(height: AppSpacing.medium),
            AyahInfoText(
              verseKey: ayah.verseKey,
            ),
          ],
        ),
      ),
    );
  }
}
