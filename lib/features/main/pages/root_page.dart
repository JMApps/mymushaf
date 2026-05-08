import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../states/database_init_state.dart';
import 'app_loader.dart';
import 'db_init_error_page.dart';
import 'db_init_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    final dbState = context.watch<DatabaseInitState>();
    return FutureBuilder<Database>(
      future: dbState.dbFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return DBInitErrorPage(
            error: snapshot.error.toString(),
            onRetry: context.read<DatabaseInitState>().retry,
          );
        }

        final db = snapshot.data;

        if (db == null) {
          return const DbInitPage();
        }

        return AppLoader(db: db);
      },
    );
  }
}
