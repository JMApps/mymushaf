import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../settings/states/reading_settings_state.dart';
import '../../domain/entities/mushaf_page_row_entity.dart';

class MushafGlyphLineItem extends StatelessWidget {
  const MushafGlyphLineItem({
    super.key,
    required this.pageNumber,
    required this.rows,
  });

  final int pageNumber;
  final List<MushafPageRowEntity> rows;

  @override
  Widget build(BuildContext context) {
    final readingSettings = context.watch<ReadingSettingsState>();

    final text = rows.map((row) => row.glyph).whereType<String>().join();

    return RepaintBoundary(
      child: Text(
        text,
        textDirection: .rtl,
        textAlign: .justify,
        style: TextStyle(
          fontFamily: 'P$pageNumber',
          fontSize: readingSettings.ayahArabicTextSize,
          height: 1.8,
          letterSpacing: 0,
        ),
      ),
    );
  }
}