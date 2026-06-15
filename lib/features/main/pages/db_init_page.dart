import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/states/display_settings_state.dart';

class DbInitPage extends StatelessWidget {
  const DbInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.read<DisplaySettingsState>();
    final theme = AppTheme(seedColor: themeState.themeColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: themeState.appThemeMode,
      builder: (context, child) {
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: Platform.isAndroid,
          maintainBottomViewPadding: true,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: Scaffold(
        body: Builder(
          builder: (context) {
            final appLocale = AppLocalizations.of(context);
            return Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  Text(appLocale.initializingData),
                  const SizedBox(height: AppSpacing.medium),
                  const CircularProgressIndicator.adaptive(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
