import '../../../../core/database/constants/column_names.dart';
import '../../domain/entities/line_type.dart';

class LayoutModel {
  final int pageNumber;
  final int lineNumber;
  final LineType lineType;
  final bool isCentered;
  final int? surahNumber;

  const LayoutModel({
    required this.pageNumber,
    required this.lineNumber,
    required this.lineType,
    required this.isCentered,
    this.surahNumber,
  });

  factory LayoutModel.fromMap(Map<String, Object?> map) => LayoutModel(
    pageNumber: map[ColumnNames.pageNumber] as int,
    lineNumber: map[ColumnNames.lineNumber] as int,
    lineType: LineType.fromDb(map[ColumnNames.lineType] as String),
    isCentered: (map[ColumnNames.isCentered] as int) == 1,
    surahNumber: map[ColumnNames.surahNumber] as int?,
  );
}
