import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../hizb/presentation/states/hizb_state.dart';
import '../../juz/presentation/states/juz_state.dart';
import '../../settings/states/theme_state.dart';
import '../../surah/presentation/states/surah_name_state.dart';
import 'home_page.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
    required this.db,
  });

  final Database db;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  late final AppDependencies _deps = AppDependencies.build(widget.db);

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeState>();
    final theme = AppTheme(seedColor: themeState.seedColor);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SurahNameState(_deps.surahNameRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => JuzState(_deps.juzRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => HizbState(_deps.hizbRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        themeMode: themeState.themeMode,
        home: const HomePage(),
      ),
    );
  }
}