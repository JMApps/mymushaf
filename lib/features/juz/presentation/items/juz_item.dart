import 'package:flutter/material.dart';
import 'package:mymushaf/features/surah/presentation/states/surah_name_state.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/juz_entity.dart';

class JuzItem extends StatelessWidget {
  const JuzItem({
    super.key,
    required this.juz,
    required this.index,
  });

  final JuzEntity juz;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;
    final itemOddColor = appColors.secondary.withAlpha(25);
    final itemEvenColor = appColors.secondary.withAlpha(05);
    final surahFirstVerseKey = context.select<SurahNameState, String>((s) => s.surahByVerseKey(juz.firstVerseKey, appLocale.ayah.toLowerCase()));
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
                juz.juzNumber.toString(),
              ),
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    surahFirstVerseKey,
                    style: AppTextStyles.mediumTextStyle,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  Text(
                    appLocale.ayahsCount(juz.versesCount).toString(),
                    style: AppTextStyles.smallTextStyle,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Text(
              juz.startPageNumber.toString(),
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
