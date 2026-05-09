import 'package:flutter/material.dart';

import '../../../../core/theme/app_paddings.dart';
import '../../../settings/states/reading_settings_state.dart';

class BasmallahItem extends StatelessWidget {
  const BasmallahItem({
    super.key,
    required this.readingSettingsState,
  });

  final ReadingSettingsState readingSettingsState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottomMedium,
      child: Text(
        '\uFDFD',
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: readingSettingsState.ayahArabicTextSize + 5.0,
          fontFamily: 'QCF BSML',
          height: 1,
        ),
        textAlign: .center,
      ),
    );
  }
}
