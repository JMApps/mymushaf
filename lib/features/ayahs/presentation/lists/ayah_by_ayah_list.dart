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

    final surahsWithHeader = <int>{};
    final surahsWithBasmallah = <int>{};

    int? lastSurahHeader;

    for (final layout in layouts) {
      if (layout.lineType == LineType.surahName) {
        final surahNumber = layout.surahNumber;

        if (surahNumber != null) {
          surahsWithHeader.add(surahNumber);
          lastSurahHeader = surahNumber;
        }
        continue;
      }

      if (layout.lineType == LineType.basmallah) {
        if (lastSurahHeader != null) {
          surahsWithBasmallah.add(lastSurahHeader);
        }
        continue;
      }
    }

    int? currentSurah;

    for (var i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];
      final surahNumber = ayah.surahNumber;

      final isNewSurah = currentSurah != surahNumber;

      if (isNewSurah) {
        lines.add(SurahLine(surahNumber));
        final shouldShowBasmallah = surahsWithBasmallah.contains(surahNumber) && surahNumber != 1 && surahNumber != 9;
        if (shouldShowBasmallah) {
          lines.add(const BasmallahLine());
        }
        currentSurah = surahNumber;
      }

      lines.add(AyahLine(ayah, i));
    }

    return lines;
  }
}
