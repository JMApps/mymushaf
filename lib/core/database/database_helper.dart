import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class QuranDatabaseService {
  QuranDatabaseService._();

  static final QuranDatabaseService instance = QuranDatabaseService._();

  static const String _dbFileName = 'mushaf_database.db';
  static const String _assetPath = 'assets/databases/$_dbFileName';
  static const int _dbVersion = 1;

  Database? _db;
  Future<Database>? _opening;

  Future<Database> get db {
    final existing = _db;
    if (existing != null) return Future.value(existing);

    final opening = _opening;
    if (opening != null) return opening;

    final future = _open();
    _opening = future;
    return future;
  }

  Future<Database> _open() async {
    final dbDir = await getDatabasesPath();
    final dbPath = p.join(dbDir, _dbFileName);

    await Directory(p.dirname(dbPath)).create(recursive: true);
    await _ensureDatabaseInstalled(dbPath);

    final database = await openDatabase(
      dbPath,
      singleInstance: true,
      readOnly: true,
    );

    _db = database;
    _opening = null;
    return database;
  }

  Future<void> _ensureDatabaseInstalled(String dbPath) async {
    final file = File(dbPath);

    if (!await file.exists()) {
      await _installFreshFromAssets(dbPath);
      return;
    }

    final probe = await openDatabase(dbPath, singleInstance: false);
    final int currentVersion;
    try {
      currentVersion = await probe.getVersion();
    } finally {
      await probe.close();
    }

    if (currentVersion >= _dbVersion) return;

    await deleteDatabase(dbPath);
    await _installFreshFromAssets(dbPath);
  }

  Future<void> _installFreshFromAssets(String dbPath) async {
    await _copyAssetDbTo(dbPath);

    final rw = await openDatabase(dbPath, singleInstance: false);
    try {
      await rw.transaction((txn) async {
        await _createIndexes(txn);
        await _createFts(txn);
      });
      await rw.execute('ANALYZE');
      await rw.setVersion(_dbVersion);
    } finally {
      await rw.close();
    }
  }

  Future<void> _createIndexes(Transaction txn) async {
    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_glyphs_surah_ayah ON Table_of_glyphs(surah_number, ayah_number)',
    );
    await txn.execute('CREATE INDEX IF NOT EXISTS idx_glyphs_location ON Table_of_glyphs(location)');
    await txn.execute('CREATE INDEX IF NOT EXISTS idx_layouts_page ON Table_of_layouts(page_number)');
    await txn.execute('CREATE INDEX IF NOT EXISTS idx_ayahs_verse_key ON Table_of_ayah_by_ayah(verse_key)');
    await txn.execute('CREATE INDEX IF NOT EXISTS idx_translations_ayah_key ON Table_of_translations(ayah_key)');
  }

  Future<void> _createFts(Transaction txn) async {
    await txn.execute('''
    CREATE VIRTUAL TABLE IF NOT EXISTS fts_ayahs_arabic
    USING fts4(verse_key, text, tokenize=unicode61, notindexed=verse_key)
    ''');
    await txn.execute('''
    INSERT INTO fts_ayahs_arabic(verse_key, text)
    SELECT verse_key, text FROM Table_of_ayah_by_ayah_normalized
  ''');

    // FTS4 для поиска по переводам.
    await txn.execute('''
      CREATE VIRTUAL TABLE IF NOT EXISTS fts_translations
      USING fts4(ayah_key, ru_kuliev, ru_adel, kg, uz, az, tokenize=unicode61, notindexed=ayah_key)
    ''');
    await txn.execute('''
      INSERT INTO fts_translations(ayah_key, ru_kuliev, ru_adel, kg, uz, az)
      SELECT ayah_key, ayah_ru_kuliev, ayah_ru_adel, ayah_kg, ayah_uz, ayah_az
      FROM Table_of_translations
    ''');
  }

  Future<void> _copyAssetDbTo(String dbPath) async {
    final data = await rootBundle.load(_assetPath);
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(dbPath).writeAsBytes(bytes, flush: true);
  }

  Future<void> close() async {
    _opening = null;
    final database = _db;
    _db = null;
    if (database != null) {
      await database.close();
    }
  }

  Future<Database> reinstallFromAssets() async {
    final dbDir = await getDatabasesPath();
    final dbPath = p.join(dbDir, _dbFileName);

    await close();
    await deleteDatabase(dbPath);
    await _installFreshFromAssets(dbPath);

    return db;
  }
}
