import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../main/states/page_number_state.dart';

class ToPageButton extends StatelessWidget {
  const ToPageButton({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Container(
              margin: AppPaddings.topMedium,
              padding: AppPaddings.withoutTopMedium,
              child: Column(
                mainAxisSize: .min,
                children: [
                  Consumer<PageNumberState>(
                    builder: (context, pageNumberState, _) {
                      return SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 1.75,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                        ),
                        child: Directionality(
                          textDirection: .rtl,
                          child: Slider(
                            showValueIndicator: .alwaysVisible,
                            value: pageNumberState.pageNumber.toDouble(),
                            label: '${pageNumberState.pageNumber}',
                            min: 1,
                            max: AppConstants.totalMushafPageCount.toDouble(),
                            divisions: AppConstants.totalMushafPageCount,
                            onChanged: (double value) {
                              pageNumberState.setPageNumber(value.round());
                            },
                            onChangeEnd: (double value) {
                              int pageNumber = value.round();
                              if (pageController.hasClients) {
                                pageController.jumpToPage(pageNumber - 1);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    appLocale.jumpToPage,
                    style: AppTextStyles.medium,
                  ),
                  const SizedBox(height: AppSpacing.small),
                ],
              ),
            );
          },
        );
      },
      padding: .zero,
      tooltip: appLocale.goTo,
      icon: const Icon(Icons.auto_stories_outlined),
    );
  }
}
