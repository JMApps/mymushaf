import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/main/pages/root_page.dart';
import 'features/main/states/database_init_state.dart';
import 'features/main/states/main_state.dart';
import 'features/settings/states/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainState(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseInitState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeState(),
        ),
      ],
      child: const RootPage(),
    ),
  );
}
