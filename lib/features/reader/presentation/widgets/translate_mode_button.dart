import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../main/states/translate_mode_state.dart';

class TranslateModeButton extends StatelessWidget {
  const TranslateModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Consumer<TranslateModeState>(
      builder: (context, translationMode, _) {
        return IconButton(
          onPressed: () {
            translationMode.toggleTranslateMode();
          },
          padding: .zero,
          visualDensity: .compact,
          tooltip: translationMode.translateMode ? appLocale.mushafPage : appLocale.semanticTranslation,
          icon: Icon(
            translationMode.translateMode ? Icons.menu_book_rounded : Icons.public_outlined,
          ),
        );
      },
    );
  }
}
