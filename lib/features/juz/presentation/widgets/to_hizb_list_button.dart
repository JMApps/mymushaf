import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../hizb/domain/entities/hizb_entity.dart';
import '../../../hizb/presentation/lists/hizb_list.dart';
import '../../../hizb/presentation/states/hizb_state.dart';

class ToHizbsPageButton extends StatelessWidget {
  const ToHizbsPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final isLoading = context.select<HizbState, bool>((s) => s.isLoading);
    final hizbs = context.select<HizbState, List<HizbEntity>>((s) => s.hizbs);
    return isLoading ? const CircularProgressIndicator.adaptive() : IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) {
            return HizbList(hizbs: hizbs);
          },
        );
      },
      tooltip: appLocale.hizbs,
      icon: const Icon(Icons.pie_chart),
    );
  }
}
