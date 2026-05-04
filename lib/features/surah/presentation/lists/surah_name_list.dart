import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/surah_name_entity.dart';
import '../items/surah_name_item.dart';

class SurahNameList extends StatelessWidget {
  const SurahNameList({
    super.key,
    required this.surahs,
  });

  final List<SurahNameEntity> surahs;

  @override
  Widget build(BuildContext context) {
    final double bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;
    return Scrollbar(
      child: ListView.builder(
        primary: false,
        padding: .only(bottom: bottomHeight),
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return SurahNameItem(
            surah: surah,
            index: index,
          );
        },
      ),
    );
  }
}
