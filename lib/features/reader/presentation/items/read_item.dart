import 'package:flutter/material.dart';

import '../../../ayahs/presentation/lists/ayah_by_ayah_list.dart';
import '../../domain/entities/mushaf_page_row_entity.dart';

class ReadItem extends StatelessWidget {
  const ReadItem({
    super.key,
    required this.pageNumber,
    required this.rows,
  });

  final int pageNumber;
  final List<MushafPageRowEntity> rows;

  @override
  Widget build(BuildContext context) {
    // final translationMode = context.select<TranslateModeState, bool>(
    //   (s) => s.translateMode,
    // );
    // if (translationMode) {
    //   return AyahByAyahList(pageNumber: pageNumber, rows: rows);
    // }
    //
    // return MushafGlyphPageList(pageNumber: pageNumber, rows: rows);
    return AyahByAyahList(pageNumber: pageNumber, rows: rows);
  }
}
