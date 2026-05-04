import 'package:flutter/material.dart';

import '../../../../core/constants/font_families.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/surah_name_entity.dart';

class SurahNameItem extends StatelessWidget {
  const SurahNameItem({
    super.key,
    required this.surah,
    required this.index,
  });

  final SurahNameEntity surah;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;
    final itemOddColor = appColors.secondary.withAlpha(25);
    final itemEvenColor = appColors.secondary.withAlpha(05);
    return InkWell(
      splashColor: appColors.inversePrimary.withAlpha(75),
      focusColor: appColors.inversePrimary.withAlpha(55),
      onTap: () async {},
      child: Container(
        padding: AppPaddings.hrSmallVrLarge,
        decoration: BoxDecoration(
          color: index.isOdd ? itemEvenColor : itemOddColor,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                surah.surahNumber.toString(),
              ),
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    FontFamilies.glyphForSurahNumber(surah.surahNumber),
                    style: TextStyle(
                      color: appColors.primary,
                      fontFamily: FontFamilies.surahHeader,
                      fontSize: 27.5,
                      height: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          surah.nameTranscriptionRu,
                          style: AppTextStyles.mediumTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          ' (${surah.nameTranslationRu})',
                          style: AppTextStyles.mediumTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${appLocale.ayahsCount(surah.ayahsCount).toString()} • ${surah.revelationPlace == 0 ? appLocale.mecca : appLocale.medina}',
                    style: AppTextStyles.smallTextStyle,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Text(
              surah.startPageNumber.toString(),
              style: AppTextStyles.smallTextStyle.copyWith(
                color: appColors.secondary,
              ),
            ),
            const SizedBox(width: AppSpacing.small),
          ],
        ),
      ),
    );
  }
}
