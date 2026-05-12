import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';
import '../enums/app_theme_mode.dart';

extension AppThemeModeX on AppThemeMode {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (this) {
      case AppThemeMode.system:
        return l10n.themeSystem;

      case AppThemeMode.light:
        return l10n.themeLight;

      case AppThemeMode.dark:
        return l10n.themeDark;
    }
  }
}