import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../reader/domain/entities/layout_entity.dart';
import '../../../reader/domain/entities/line_type.dart';
import '../../domain/entities/ayah_by_ayah_entity.dart';
import '../items/ayah_by_ayah_item.dart';
import '../items/basmallah_item.dart';
import '../items/surah_header_item.dart';
import '../states/ayah_by_ayah_state.dart';
import 'page_line.dart';

class AyahByAyahList extends StatelessWidget {
  final int pageNumber;
  final List<LayoutEntity> layouts;
  final int? ayahPosition;

  const AyahByAyahList({
    super.key,
    required this.pageNumber,
    required this.layouts,
    this.ayahPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AyahByAyahState, ({bool loading, Object? error, bool loaded})>(
      selector: (_, s) => (
      loading: s.isPageLoading(pageNumber),
      error: s.getPageError(pageNumber),
      loaded: s.isPageLoaded(pageNumber),
      ),
      builder: (context, state, _) => switch (state) {
        (loading: true, error: _, loaded: _) => const Center(child: CircularProgressIndicator.adaptive()),
        (loading: _, error: final e?, loaded: _) => Padding(
          padding: AppPaddings.medium,
          child: Center(child: Text('$e')),
        ),
        (loading: _, error: _, loaded: true) => _buildList(context),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildList(BuildContext context) {
    final ayahs = context.read<AyahByAyahState>().getPageAyahs(pageNumber);
    final headers = {
      for (final l in layouts)
        if (l.lineType == LineType.surahName) l.surahNumber!,
    };
    final hasBasmallah = layouts.any((l) => l.lineType == LineType.basmallah);
    final lines = _buildLines(ayahs, headers, hasBasmallah);

    return ListView.builder(
      padding: AppPaddings.topMediumSmallOther,
      itemCount: lines.length,
      itemBuilder: (context, index) => switch (lines[index]) {
        SurahLine(surahNumber: final n) => SurahHeaderItem(surahNumber: n),
        BasmallahLine() => const BasmallahItem(),
        AyahLine(ayah: final ayahModel, index: final index) => AyahByAyahItem(
          ayahByAyahModel: ayahModel,
          index: index,
        ),
      },
    );
  }

  static List<PageLine> _buildLines(List<AyahByAyahEntity> ayahs, Set<int> headers, bool hasBasmallah) {
    final lines = <PageLine>[];
    int? lastSurah;

    if (headers.isEmpty && ayahs.isNotEmpty) {
      lines.add(SurahLine(ayahs.first.surahNumber));
      lastSurah = ayahs.first.surahNumber;
    }

    for (var i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];

      if (ayah.surahNumber != lastSurah) {
        lines.add(SurahLine(ayah.surahNumber));
        if (headers.contains(ayah.surahNumber) && hasBasmallah && ayah.surahNumber != 1 && ayah.surahNumber != 9) {
          lines.add(const BasmallahLine());
        }
        lastSurah = ayah.surahNumber;
      }

      lines.add(AyahLine(ayah, i));
    }

    return lines;
  }
}