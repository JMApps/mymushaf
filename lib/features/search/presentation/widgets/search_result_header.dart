import 'package:flutter/material.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({
    super.key,
    required this.query,
    required this.matchCount,
    required this.resultCount,
  });

  final String query;
  final int matchCount;
  final int resultCount;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;

    final matchesText = appLocale.searchResults(matchCount);

    return Container(
      padding: AppPaddings.small,
      color: appColors.tertiaryContainer,
      child: Text(
        appLocale.searchByQuery(query, matchesText),
        style: AppTextStyles.medium,
        textAlign: .center,
        overflow: .ellipsis,
      ),
    );
  }
}
