import 'package:flutter/material.dart';

import '../constants/font_families.dart';

class AppTextStyles {
  AppTextStyles._();

  static const smallTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: FontFamilies.ptSans,
  );

  static const mediumTextStyle = TextStyle(
    fontSize: 17,
    fontFamily: FontFamilies.ptSans,
  );

  static const largeTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: FontFamilies.ptSans,
  );
}