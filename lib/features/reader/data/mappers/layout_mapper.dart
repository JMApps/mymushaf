import '../../domain/entities/layout_entity.dart';
import '../models/layout_model.dart';

extension LayoutMapper on LayoutModel {
  LayoutEntity layoutToEntity() {
    return LayoutEntity(
      pageNumber: pageNumber,
      lineNumber: lineNumber,
      firstWordId: firstWordId,
      lastWordId: lastWordId,
      lineType: lineType,
      isCentered: isCentered,
      surahNumber: surahNumber,
    );
  }
}
