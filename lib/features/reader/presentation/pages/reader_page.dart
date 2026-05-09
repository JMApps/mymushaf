import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main/states/page_number_state.dart';
import '../lists/reader_page_list.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({
    super.key,
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.select<PageNumberState, int>((s) => s.pageNumber).toString()),
      ),
      body: ReaderPageList(
        pageNumber: pageNumber,
      ),
    );
  }
}
