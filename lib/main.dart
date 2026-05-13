import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_setting_strings.dart';
import 'features/bookmarks/presentation/states/bookmarks_state.dart';
import 'features/main/pages/root_page.dart';
import 'features/main/states/database_init_state.dart';
import 'features/main/states/main_state.dart';
import 'features/main/states/page_number_state.dart';
import 'features/main/states/translate_mode_state.dart';
import 'features/reader/presentation/states/reader_app_bar_state.dart';
import 'features/settings/states/display_settings_state.dart';
import 'features/settings/states/locale_settings_state.dart';
import 'features/settings/states/reading_settings_state.dart';
import 'features/settings/states/settings_reset_coordinator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await _openBoxWithRecovery(AppSettingStrings.mainAppSettingsBox);
  await _openBoxWithRecovery(AppSettingStrings.mainBookmarksBox);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseInitState()),
        ChangeNotifierProvider(create: (_) => MainState()),
        ChangeNotifierProvider(create: (_) => ReaderAppBarState()),
        ChangeNotifierProvider(create: (_) => PageNumberState()),
        ChangeNotifierProvider(create: (_) => TranslateModeState()),
        ChangeNotifierProvider(create: (_) => LocaleSettingsState()),
        ChangeNotifierProvider(create: (_) => ReadingSettingsState()),
        ChangeNotifierProvider(create: (_) => DisplaySettingsState()),
        ChangeNotifierProvider(create: (_) => BookmarksState()),
        Provider<SettingsResetCoordinator>(
          create: (context) => SettingsResetCoordinator(
            context.read<LocaleSettingsState>(),
            context.read<DisplaySettingsState>(),
            context.read<ReadingSettingsState>(),
          ),
        ),
      ],
      child: const RootPage(),
    ),
  );
}

Future<void> _openBoxWithRecovery(String name) async {
  try {
    await Hive.openBox(name);
  } catch (_, _) {
    await Hive.deleteBoxFromDisk(name);
    await Hive.openBox(name);
  }
}