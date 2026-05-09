import 'package:equatable/equatable.dart';

import 'line_type.dart';

class LayoutEntity extends Equatable {
  final int pageNumber;
  final int lineNumber;
  final LineType lineType;
  final bool isCentered;
  final int? surahNumber;

  const LayoutEntity({
    required this.pageNumber,
    required this.lineNumber,
    required this.lineType,
    required this.isCentered,
    required this.surahNumber,
  });

  @override
  List<Object?> get props => [
    pageNumber,
    lineNumber,
    lineType,
    isCentered,
    surahNumber,
  ];
}
