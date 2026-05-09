import 'package:flutter/material.dart';

import '../../../ayahs/presentation/lists/ayah_by_ayah_list.dart';
import '../../domain/entities/layout_entity.dart';

class ReadItem extends StatelessWidget {
  const ReadItem({super.key, required this.pageNumber, required this.layouts});

  final int pageNumber;
  final List<LayoutEntity> layouts;

  @override
  Widget build(BuildContext context) {
    return AyahByAyahList(pageNumber: pageNumber, layouts: layouts);
  }
}
