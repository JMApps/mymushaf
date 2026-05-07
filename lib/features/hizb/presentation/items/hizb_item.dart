import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../surah/presentation/states/surah_name_state.dart';
import '../../domain/entities/hizb_entity.dart';

class HizbItem extends StatelessWidget {
  const HizbItem({
    super.key,
    required this.hizb,
    required this.index,
  });

  final HizbEntity hizb;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;
    final itemOddColor = appColors.secondary.withAlpha(25);
    final itemEvenColor = appColors.secondary.withAlpha(05);
    final surahFirstVerseKey = context.select<SurahNameState, String>((s) => s.surahByVerseKey(hizb.firstVerseKey, appLocale.ayah.toLowerCase()));
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
                hizb.hizbNumber.toString(),
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
                    appLocale.ayahsCount(hizb.versesCount).toString(),
                    style: AppTextStyles.smallTextStyle,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Text(
              hizb.startPageNumber.toString(),
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
