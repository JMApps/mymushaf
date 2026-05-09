import 'package:flutter/material.dart';

import '../../../../core/constants/font_families.dart';
import '../../../../core/theme/app_paddings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../settings/states/reading_settings_state.dart';
import '../../domain/entities/ayah_by_ayah_entity.dart';

class AyahByAyahItem extends StatelessWidget {
  const AyahByAyahItem({
    super.key,
    required this.ayahByAyahModel,
    required this.readingSettingsState,
    required this.index,
  });

  final AyahByAyahEntity ayahByAyahModel;
  final ReadingSettingsState readingSettingsState;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return RepaintBoundary(
      child: GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => Container(),
          );
        },
        child: Container(
          padding: AppPaddings.hrSmallVrLarge,
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 0.25,
                color: Colors.grey,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: 65,
                padding: AppPaddings.small,
                alignment: .center,
                decoration: BoxDecoration(
                  color: appColors.secondaryContainer.withAlpha(155),
                  borderRadius: AppRadius.small,
                ),
                child: Text(ayahByAyahModel.verseKey),
              ),
              if (readingSettingsState.isArabicAyahShow) ...[
                const SizedBox(height: AppSpacing.medium),
                Align(
                  alignment: .centerEnd,
                  child: Text(
                    ayahByAyahModel.ayahArabic,
                    textDirection: .rtl,
                    style: TextStyle(
                      fontSize: readingSettingsState.ayahArabicTextSize,
                      fontFamily: FontFamilies.uthmanic,
                      height: 2.25,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
              if (readingSettingsState.isTranslationAyahShow) ...[
                const SizedBox(height: AppSpacing.medium),
                Text(
                  ayahByAyahModel.ayahTranslation,
                  style: TextStyle(
                    fontSize: readingSettingsState.ayahTranslationTextSize,
                    fontFamily: FontFamilies.ptSans,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}