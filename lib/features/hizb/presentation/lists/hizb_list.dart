import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/hizb_entity.dart';
import '../items/hizb_item.dart';
class HizbList extends StatelessWidget {
  const HizbList({
    super.key,
    required this.hizbs,
  });

  final List<HizbEntity> hizbs;
  @override
  Widget build(BuildContext context) {
    final double bottomHeight = kBottomNavigationBarHeight + AppSpacing.medium;
    return Scrollbar(
      controller: ScrollController(),
      child: ListView.builder(
        controller: ScrollController(),
        primary: false,
        padding: .only(bottom: bottomHeight),
        itemCount: hizbs.length,
        itemBuilder: (context, index) {
          final hizb = hizbs[index];
          return HizbItem(
            hizb: hizb,
            index: index,
          );
        },
      ),
    );
  }
}
