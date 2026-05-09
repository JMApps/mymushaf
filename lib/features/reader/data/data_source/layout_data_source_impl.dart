import 'package:sqflite/sqflite.dart';

import '../../../../core/database/constants/column_names.dart';
import '../../../../core/database/constants/table_names.dart';
import '../models/layout_model.dart';
import 'layout_local_data_source.dart';

class LayoutDataSourceImpl implements LayoutLocalDataSource {
  final Database _database;

  const LayoutDataSourceImpl(this._database);

  @override
  Future<List<LayoutModel>> fetchLayoutByPageNumber({required int pageNumber}) async {
    final result = await _database.rawQuery(
      '''
      SELECT ${ColumnNames.pageNumber}, ${ColumnNames.lineNumber}, ${ColumnNames.lineType}, ${ColumnNames.isCentered}, ${ColumnNames.numberSurah}
      FROM ${TableNames.tableOfLayout}
      WHERE ${ColumnNames.pageNumber} = ?
      ORDER BY ${ColumnNames.lineNumber}
      ''',
      [pageNumber],
    );
    return result.map(LayoutModel.fromMap).toList(growable: false);
  }
}