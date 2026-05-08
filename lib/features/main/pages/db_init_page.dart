import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../l10n/app_localizations.dart';

class DbInitPage extends StatelessWidget {
  const DbInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
