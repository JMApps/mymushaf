import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../reader/domain/entities/layout_entity.dart';
import '../../../reader/domain/entities/line_type.dart';
import '../items/ayah_by_ayah_item.dart';
import '../items/basmallah_item.dart';
import '../items/surah_header_item.dart';
import '../states/ayah_by_ayah_state.dart';

class AyahByAyahList extends StatefulWidget {
  final int pageNumber;
  final List<LayoutEntity> layouts;

  const AyahByAyahList({
    super.key,
    required this.pageNumber,
    required this.layouts,
  });

  @override
  State<AyahByAyahList> createState() => _AyahByAyahListState();
}

class _AyahByAyahListState extends State<AyahByAyahList> {
  @override
  void initState() {
    super.initState();
    context.read<AyahByAyahState>().loadPage(widget.pageNumber);
  }

  @override
  void didUpdateWidget(AyahByAyahList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageNumber != widget.pageNumber) {
      context.read<AyahByAyahState>().loadPage(widget.pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = widget.pageNumber;

    return Selector<AyahByAyahState, ({bool loading, Object? error, bool loaded})>(
      selector: (_, s) => (
        loading: s.isPageLoading(page),
        error: s.getPageError(page),
        loaded: s.isPageLoaded(page),
      ),
      builder: (context, state, _) => switch (state) {
        (loading: true, error: _, loaded: _) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
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
    final ayahs = context.read<AyahByAyahState>().getPageAyahs(widget.pageNumber);
    final headers = {
      for (final l in widget.layouts)
        if (l.lineType == LineType.surahName) l.surahNumber!,
    };
    final hasBasmallah = widget.layouts.any((l) => l.lineType == LineType.basmallah);

    final items = <Widget>[];
    int? lastSurah;

    for (var i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];

      if (ayah.surahNumber != lastSurah && headers.contains(ayah.surahNumber)) {
        items.add(SurahHeaderItem(surahNumber: ayah.surahNumber));
        if (hasBasmallah && ayah.surahNumber != 1 && ayah.surahNumber != 9) {
          items.add(const BasmallahItem());
        }
        lastSurah = ayah.surahNumber;
      }

      items.add(AyahByAyahItem(ayahByAyahModel: ayah, index: i));
    }

    return ListView.builder(
      padding: AppPaddings.medium,
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }
}
