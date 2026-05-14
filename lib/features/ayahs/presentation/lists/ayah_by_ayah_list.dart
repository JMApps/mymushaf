import 'package:flutter/material.dart';

import '../../../../core/enums/line_type.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../reader/domain/entities/layout_entity.dart';
import '../../domain/entities/ayah_by_ayah_entity.dart';
import '../items/ayah_by_ayah_item.dart';
import '../items/basmallah_item.dart';
import '../items/surah_header_item.dart';
import 'page_line.dart';

class AyahByAyahList extends StatelessWidget {
  const AyahByAyahList({
    super.key,
    required this.pageNumber,
    required this.layouts,
    required this.ayahs,
    this.ayahPosition,
  });

  final int pageNumber;
  final List<LayoutEntity> layouts;
  final List<AyahByAyahEntity> ayahs;
  final int? ayahPosition;

  @override
  Widget build(BuildContext context) {
    if (ayahs.isEmpty) {
      return const SizedBox.shrink();
    }

    final lines = _buildLines(
      layouts: layouts,
      ayahs: ayahs,
    );

    return ListView.builder(
      padding: AppPaddings.topMediumSmallOther,
      itemCount: lines.length,
      itemBuilder: (context, index) {
        final line = lines[index];

        return switch (line) {
          SurahLine(surahNumber: final surahNumber) => SurahHeaderItem(
            surahNumber: surahNumber,
          ),

          BasmallahLine() => const BasmallahItem(),

          AyahLine(ayah: final ayahModel, index: final ayahIndex) => AyahByAyahItem(
            ayahByAyahModel: ayahModel,
            index: ayahIndex,
          ),
        };
      },
    );
  }

  static List<PageLine> _buildLines({required List<LayoutEntity> layouts, required List<AyahByAyahEntity> ayahs}) {
    final lines = <PageLine>[];

    final sortedLayouts = [...layouts]
      ..sort((a, b) => a.lineNumber.compareTo(b.lineNumber));

    final sortedAyahs = [...ayahs]
      ..sort((a, b) => a.ayahPosition.compareTo(b.ayahPosition));

    var ayahIndex = 0;

    for (final layout in sortedLayouts) {
      switch (layout.lineType) {
        case LineType.surahName:
          final surahNumber = layout.surahNumber;
          if (surahNumber != null) {
            lines.add(SurahLine(surahNumber));
          }

        case LineType.basmallah:
          lines.add(const BasmallahLine());

        case LineType.ayah:
          if (ayahIndex < sortedAyahs.length) {
            final ayah = sortedAyahs[ayahIndex];
            lines.add(AyahLine(ayah, ayahIndex));
            ayahIndex++;
          }
      }
    }

    final hasSurahNameFromLayout = sortedLayouts.any(
          (layout) => layout.lineType == LineType.surahName,
    );

    if (!hasSurahNameFromLayout && sortedAyahs.isNotEmpty) {
      final currentSurahNumber = sortedAyahs.first.surahNumber;
      lines.insert(0, SurahLine(currentSurahNumber));
    }

    return lines;
  }
}
