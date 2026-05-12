import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_paddings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../states/display_settings_state.dart';
import '../states/locale_settings_state.dart';
import '../states/reading_settings_state.dart';
import '../widgets/ayah_text_size_slider.dart';
import '../widgets/default_settings_button.dart';
import '../widgets/setting_list_tile_item.dart';
import '../widgets/theme_color_picker.dart';
import '../widgets/theme_mode_drop_down.dart';
import '../widgets/translation_drop_down.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.settings),
        actions: const [
          DefaultSettingsButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const .only(bottom: kBottomNavigationBarHeight),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
            Consumer<ReadingSettingsState>(
              builder: (BuildContext context, readingSettings, _) {
                return Column(
                  children: [
                    SettingListTileItem(
                      value: readingSettings.arabicNameSurah,
                      title: appLocale.arabicSurahName,
                      onChanged: (bool onChanged) {
                        readingSettings.arabicNameSurah = onChanged;
                      },
                    ),
                    SettingListTileItem(
                      value: readingSettings.translationNameSurah,
                      title: appLocale.translationSurahName,
                      onChanged: (bool onChanged) {
                        readingSettings.translationNameSurah = onChanged;
                      },
                    ),
                  ],
                );
              },
            ),
            const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
            Consumer<DisplaySettingsState>(
              builder: (BuildContext context, displaySettings, _) {
                return Column(
                  children: [
                    SettingListTileItem(
                      value: displaySettings.displayAlwaysOn,
                      title: appLocale.alwaysDisplayOn,
                      onChanged: (bool onChanged) {
                        displaySettings.setDisplayAlwaysOn(onChanged);
                      },
                    ),
                    const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
                    ThemeModeDropDown(
                      value: displaySettings.appThemeModeIndex,
                      title: appLocale.appTheme,
                      onChanged: (int? index) {
                        displaySettings.appThemeModeIndex = index!;
                      },
                    ),
                    const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
                    ThemeColorPicker(
                      color: displaySettings.themeColor,
                      onChanged: (Color? color) {
                        Navigator.pop(context);
                        displaySettings.themeColor = color!;
                      },
                    ),
                    const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
                  ],
                );
              },
            ),
            Consumer<LocaleSettingsState>(
              builder: (context, localeSettings, _) {
                return TranslationDropDown(
                  selectedIndex: localeSettings.translationNameIndex,
                  onChanged: (index) {
                    localeSettings.translationNameIndex = index;
                  },
                );
              },
            ),
            Consumer<ReadingSettingsState>(
              builder: (context, readingSettings, _) {
                return Column(
                  children: [
                    SettingListTileItem(
                      value: readingSettings.isArabicAyahShow,
                      title: appLocale.arabicAyah,
                      onChanged: (onChanged) => readingSettings.isArabicAyahShow = onChanged,
                    ),
                    SettingListTileItem(
                      value: readingSettings.isTranslationAyahShow,
                      title: appLocale.translationAyah,
                      onChanged: (onChanged) => readingSettings.isTranslationAyahShow = onChanged,
                    ),
                    const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
                    Padding(
                      padding: AppPaddings.medium,
                      child: Text(
                        appLocale.ayahsTextSize,
                        style: AppTextStyles.medium,
                      ),
                    ),
                    AyahTextSizeSlider(
                      title: appLocale.arabic,
                      size: readingSettings.ayahArabicTextSize,
                      onChanged: (double value) => readingSettings.ayahArabicTextSize = value,
                    ),
                    AyahTextSizeSlider(
                      title: appLocale.translation,
                      size: readingSettings.ayahTranslationTextSize,
                      onChanged: (double value) => readingSettings.ayahTranslationTextSize = value,
                    ),
                  ],
                );
              },
            ),
            const Divider(indent: AppSpacing.medium, endIndent: AppSpacing.medium),
          ],
        ),
      ),
    );
  }
}
