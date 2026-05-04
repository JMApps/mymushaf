import 'package:flutter/material.dart';
import 'package:mymushaf/root_page.dart';
import 'package:provider/provider.dart';

import 'features/settings/states/theme_state.dart';

void main() {
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
