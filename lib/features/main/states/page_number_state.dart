import 'package:flutter/material.dart';

class PageNumberState extends ChangeNotifier {
  int _pageNumber = 0;

  int get pageNumber => _pageNumber;

  void setPageNumber(int pageNumber) {
    _pageNumber = pageNumber;
    notifyListeners();
  }
}
