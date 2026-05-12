import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/names_router.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../main/domain/entities/page_meta_entity.dart';
import '../../../main/states/page_number_state.dart';
import '../../../reader/data/args/reader_args.dart';
import '../../../surah/presentation/states/surah_name_state.dart';

class LastFavoritePageItem extends StatelessWidget {
  const LastFavoritePageItem({
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
      onTap: () {
        context.read<PageNumberState>().setPageNumber(pageMetaModel.pageNumber);
        Navigator.pushNamed(
          context,
          NamesRouter.pageReader,
          arguments: ReaderArgs(pageNumber: pageMetaModel.pageNumber),
        );
      },
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
