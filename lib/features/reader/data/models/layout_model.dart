import '../../../../core/database/constants/column_names.dart';
import '../../../../core/enums/line_type.dart';

class LayoutModel {
  final int pageNumber;
  final int lineNumber;
  final int? firstWordId;
  final int? lastWordId;
  final LineType lineType;
  final bool isCentered;
  final int? surahNumber;

  const LayoutModel({
    required this.pageNumber,
    required this.lineNumber,
    required this.firstWordId,
    required this.lastWordId,
    required this.lineType,
    required this.isCentered,
    this.surahNumber,
  });

  factory LayoutModel.fromMap(Map<String, Object?> map) => LayoutModel(
    pageNumber: map[ColumnNames.pageNumber] as int,
    lineNumber: map[ColumnNames.lineNumber] as int,
    firstWordId: map[ColumnNames.firstWordId] as int?,
    lastWordId: map[ColumnNames.lastWordId] as int?,
    lineType: LineType.fromDb(map[ColumnNames.lineType] as String),
    isCentered: (map[ColumnNames.isCentered] as int) == 1,
    surahNumber: map[ColumnNames.numberSurah] as int?,
  );
}
