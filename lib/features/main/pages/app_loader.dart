import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../l10n/app_localizations.dart';
import '../../surah/presentation/states/surah_name_state.dart';
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

          return _AppWithDb(db: db);
        },
      ),
    );
  }
}

class _AppWithDb extends StatefulWidget {
  final Database db;
  const _AppWithDb({required this.db});

  @override
  State<_AppWithDb> createState() => _AppWithDbState();
}

class _AppWithDbState extends State<_AppWithDb> {
  late final AppDependencies _deps = AppDependencies.build(widget.db);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SurahNameState(_deps.surahNameRepository),
        ),
      ],
      child: const HomePage(),
    );
  }
}