import 'package:flutter/material.dart';

import '../../../core/theme/app_paddings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';

class DBInitErrorPage extends StatelessWidget {
  const DBInitErrorPage({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          final appLocale = AppLocalizations.of(context);
          return Scaffold(
            body: Padding(
              padding: AppPaddings.medium,
              child: Center(
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text(appLocale.errorDbInit),
                    const SizedBox(height: AppSpacing.medium),
                    OutlinedButton(
                      onPressed: onRetry,
                      child: Text(
                        appLocale.retry,
                        style: AppTextStyles.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
