import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../main/domain/entities/page_meta_entity.dart';
import '../../../surah/presentation/states/surah_name_state.dart';

class FavoritePageItem extends StatelessWidget {
  const FavoritePageItem({
    super.key,
    required this.pageMetaModel,
    required this.index,
  });

  final PageMetaEntity pageMetaModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;
    final itemOddColor = appColors.secondary.withAlpha(25);
    final itemEvenColor = appColors.secondary.withAlpha(05);
    final surahNameTranscription = context.select<SurahNameState, String>((s) => s.surahByNumber(surahNumber: pageMetaModel.surahNumber)!.nameTranscriptionRu);
    return InkWell(
      onTap: () {},
      splashColor: appColors.inversePrimary,
      focusColor: appColors.inversePrimary.withAlpha(55),
      child: Container(
        padding: AppPaddings.hrSmallVrLarge,
        decoration: BoxDecoration(
          color: index.isOdd ? itemEvenColor : itemOddColor,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: null,
              padding: .zero,
              visualDensity: .compact,
              color: appColors.secondary,
              icon: Icon(
                Icons.access_time_filled_rounded,
                color: appColors.secondary,
              ),
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    '${appLocale.surah} $surahNameTranscription',
                    textAlign: .start,
                  ),
                  Text(
                    '${appLocale.pageShort} ${pageMetaModel.pageNumber}, ${appLocale.juz.toLowerCase()} ${pageMetaModel.juzNumber}',
                    textAlign: .start,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Text(
              pageMetaModel.pageNumber.toString(),
              style: TextStyle(
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
