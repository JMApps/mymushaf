import 'package:arabic_justified_text/arabic_justified_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/font_families.dart';
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
    final readingSettings = context.read<ReadingSettingsState>();

    final text = rows.map((row) => row.word).whereType<String>().join('\u202F');

    return RepaintBoundary(
      child: Text(
        text,
        textDirection: .rtl,
        textAlign: .center,
        style: TextStyle(
          fontFamily: FontFamilies.uthmanic,
          fontSize: readingSettings.ayahArabicTextSize - 2,
          height: 1.95,
          letterSpacing: 0,
        ),
      ),
    );
  }
}