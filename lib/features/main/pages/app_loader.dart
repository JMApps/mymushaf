import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../l10n/app_localizations.dart';
import '../states/database_init_state.dart';
import 'home_page.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final dbState = context.watch<DatabaseInitState>();
    return Scaffold(
      body: FutureBuilder<Database>(
        future: dbState.dbFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  Text(appLocale.errorDbInit),
                  const SizedBox(height: AppSpacing.medium),
                  OutlinedButton(
                    onPressed: context.read<DatabaseInitState>().retry,
                    child: Text(appLocale.retry),
                  ),
                ],
              ),
            );
          }

          final db = snapshot.data;

          if (db == null) {
            return Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  const SizedBox(height: AppSpacing.medium),
                  Text(appLocale.initializingData),
                ],
              ),
            );
          }

          return const HomePage();
        },
      ),
    );
  }
}
