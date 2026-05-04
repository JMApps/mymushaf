import 'package:flutter/material.dart';

import 'core/constants/font_families.dart';
import 'core/database/database_helper.dart';
import 'core/theme/app_paddings.dart';
import 'core/theme/app_spacing.dart';
import 'home_page.dart';
import 'l10n/app_localizations.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QuranDatabaseService.instance.db,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _ErrorScreen(error: snapshot.error);
        if (snapshot.connectionState != ConnectionState.done) {
          return const _LoadingScreen();
        }
        return const HomePage();
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(height: AppSpacing.m),
            Text(
              AppLocalizations.of(context).initializingData,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: FontFamilies.ptSans,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final Object? error;

  const _ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppPaddings.medium,
          child: Text('$error', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
