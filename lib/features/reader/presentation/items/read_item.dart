import 'package:flutter/material.dart';

import '../../domain/entities/layout_entity.dart';

class ReadItem extends StatefulWidget {
  const ReadItem({
    super.key,
    required this.pageNumber,
    required this.layouts,
  });

  final int pageNumber;
  final List<LayoutEntity> layouts;

  @override
  State<ReadItem> createState() => _ReadItemState();
}

class _ReadItemState extends State<ReadItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
