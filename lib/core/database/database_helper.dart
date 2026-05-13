import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

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
    try {
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
      return database;
    } catch (_) {
      _db = null;
      rethrow;
    } finally {
      _opening = null;
    }
  }

  Future<void> _ensureDatabaseInstalled(String dbPath) async {
    final file = File(dbPath);

    if (!await file.exists()) {
      await _installFreshFromAssets(dbPath);
      return;
    }

    final isValid = await _isExistingDatabaseValid(dbPath);
    if (!isValid) {
      await deleteDatabase(dbPath);
      await _installFreshFromAssets(dbPath);
      return;
    }

    final currentVersion = await _readDatabaseVersion(dbPath);
    if (currentVersion >= _dbVersion) return;

    await deleteDatabase(dbPath);
    await _installFreshFromAssets(dbPath);
  }

  Future<bool> _isExistingDatabaseValid(String dbPath) async {
    Database? probe;

    try {
      probe = await openDatabase(
        dbPath,
        singleInstance: false,
        readOnly: true,
      );

      await probe.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = ? LIMIT 1',
        ['table'],
      );

      return true;
    } catch (_) {
      return false;
    } finally {
      await probe?.close();
    }
  }

  Future<int> _readDatabaseVersion(String dbPath) async {
    Database? probe;

    try {
      probe = await openDatabase(
        dbPath,
        singleInstance: false,
        readOnly: true,
      );

      return probe.getVersion();
    } finally {
      await probe?.close();
    }
  }

  Future<void> _installFreshFromAssets(String dbPath) async {
    await _copyAssetDbTo(dbPath);

    final rw = await openDatabase(
      dbPath,
      singleInstance: false,
      readOnly: false,
    );

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
      'CREATE INDEX IF NOT EXISTS idx_glyphs_surah_ayah '
          'ON Table_of_glyph(surah_number, ayah_number)',
    );

    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_glyphs_location '
          'ON Table_of_glyph(location)',
    );

    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_layout_page_line_words '
          'ON Table_of_layout(page_number, line_number, first_word_id, last_word_id)',
    );

    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_ayahs_page_position '
          'ON Table_of_ayah_by_ayah(page_number, ayah_position)',
    );

    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_ayahs_verse_key '
          'ON Table_of_ayah_by_ayah(verse_key)',
    );

    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_translations_ayah_key '
          'ON Table_of_translation(ayah_key)',
    );
  }

  Future<void> _createFts(Transaction txn) async {
    await txn.execute('''
      CREATE VIRTUAL TABLE IF NOT EXISTS fts_ayahs_arabic
      USING fts4(ayah_normalized, tokenize=unicode61)
    ''');

    await txn.execute('DELETE FROM fts_ayahs_arabic');

    await txn.execute('''
      INSERT INTO fts_ayahs_arabic(rowid, ayah_normalized)
      SELECT ayah_id, ayah_normalized
      FROM Table_of_ayah_by_ayah
    ''');

    await txn.execute('''
      CREATE VIRTUAL TABLE IF NOT EXISTS fts_translations
      USING fts4(
        ayah_ru_kuliev,
        ayah_ru_adel,
        ayah_kg,
        ayah_uz,
        ayah_az,
        tokenize=unicode61
      )
    ''');

    await txn.execute('DELETE FROM fts_translations');

    await txn.execute('''
      INSERT INTO fts_translations(
        rowid,
        ayah_ru_kuliev,
        ayah_ru_adel,
        ayah_kg,
        ayah_uz,
        ayah_az
      )
      SELECT
        id,
        ayah_ru_kuliev,
        ayah_ru_adel,
        ayah_kg,
        ayah_uz,
        ayah_az
      FROM Table_of_translation
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