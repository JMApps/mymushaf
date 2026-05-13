import 'package:sqflite/sqflite.dart';

import '../../../../core/database/constants/column_names.dart';
import '../../../../core/database/constants/table_names.dart';
import '../models/glyph_model.dart';
import 'glyph_local_data_source.dart';

class GlyphDataSourceImpl implements GlyphLocalDataSource {
  final Database _database;

  const GlyphDataSourceImpl(this._database);

  @override
  Future<List<GlyphModel>> fetchGlyphByPageNumber({required int pageNumber}) async {
    final result = await _database.rawQuery(
      '''
      SELECT
        g.${ColumnNames.id},
        g.${ColumnNames.location},
        g.${ColumnNames.surahNumber},
        g.${ColumnNames.ayahNumber},
        g.${ColumnNames.wordNumber},
        g.${ColumnNames.glyph},
        g.${ColumnNames.word},

        l.${ColumnNames.pageNumber},
        l.${ColumnNames.lineNumber},
        l.${ColumnNames.lineType},
        l.${ColumnNames.isCentered},
        l.first_word_id,
        l.last_word_id,
        l.${ColumnNames.numberSurah}
      FROM ${TableNames.tableOfLayout} l
      INNER JOIN ${TableNames.tableOfGlyph} g
        ON g.id BETWEEN l.first_word_id AND l.last_word_id
      WHERE l.${ColumnNames.pageNumber} = ?
        AND l.${ColumnNames.lineType} = 'ayah'
        AND l.first_word_id IS NOT NULL
        AND l.last_word_id IS NOT NULL
      ORDER BY
        l.${ColumnNames.lineNumber} ASC,
        g.id ASC
      ''',
      [pageNumber],
    );

    return result.map(GlyphModel.fromMap).toList(growable: false);
  }
}