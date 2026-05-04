import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/settings/states/theme_state.dart';
import 'home_page.dart';
import 'l10n/app_localizations.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeState>();
    final theme = AppTheme(seedColor: themeState.seedColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: themeState.themeMode,
      home: const HomePage(),
    );
  }
}
