import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ayahs/domain/entities/ayah_by_ayah_entity.dart';
import '../../../ayahs/presentation/lists/ayah_by_ayah_list.dart';
import '../../../main/states/translate_mode_state.dart';
import '../../domain/entities/glyph_entity.dart';
import '../../domain/entities/layout_entity.dart';

class ReadItem extends StatelessWidget {
  const ReadItem({
    super.key,
    required this.pageNumber,
    required this.layouts,
    required this.glyphs,
    required this.ayahs,
  });

  final int pageNumber;
  final List<LayoutEntity> layouts;
  final List<GlyphEntity> glyphs;
  final List<AyahByAyahEntity> ayahs;

  @override
  Widget build(BuildContext context) {
    final translationMode = context.select<TranslateModeState, bool>((s) => s.translateMode);

    if (translationMode) {
      return AyahByAyahList(
        pageNumber: pageNumber,
        layouts: layouts,
        ayahs: ayahs,
      );
    }

    return AyahByAyahList(
      pageNumber: pageNumber,
      layouts: layouts,
      ayahs: ayahs,
    );
  }
}