import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../ayahs/presentation/states/ayah_by_ayah_state.dart';
import '../../hizb/presentation/states/hizb_state.dart';
import '../../juz/presentation/states/juz_state.dart';
import '../../reader/presentation/states/mushaf_page_row_state.dart';
import '../../settings/states/display_settings_state.dart';
import '../../settings/states/locale_settings_state.dart';
import '../../surah/presentation/states/surah_name_state.dart';
import '../states/page_meta_state.dart';
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
    final themeState = context.watch<DisplaySettingsState>();
    final theme = AppTheme(seedColor: themeState.themeColor);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PageMetaState(_deps.pageMetaRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => SurahNameState(_deps.surahNameRepository),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => JuzState(_deps.juzRepository),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => HizbState(_deps.hizbRepository),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AyahByAyahState(_deps.ayahByAyahRepository, context.read<LocaleSettingsState>()),
        ),
        ChangeNotifierProvider(
          create: (_) => MushafPageRowState(pageRepository: _deps.mushafPageRepository, localeSettings: context.read<LocaleSettingsState>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        onGenerateRoute: AppRoutes.onRouteGenerator,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        themeMode: themeState.appThemeMode,
        home: const HomePage(),
      ),
    );
  }
}
