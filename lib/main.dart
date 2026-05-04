import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:mymushaf/root_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/settings/states/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeState(),
        ),
      ],
      child: const RootPage(),
    ),
  );
}