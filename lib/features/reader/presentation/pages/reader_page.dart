import 'package:flutter/material.dart';

import '../lists/reader_page_list.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({
    super.key,
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return ReaderPageList(
      initialPage: pageNumber,
    );
  }
}
