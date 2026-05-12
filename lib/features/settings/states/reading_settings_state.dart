import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_setting_strings.dart';

class ReadingSettingsState extends ChangeNotifier {
  final Box<dynamic> _appSettingsBox = Hive.box(AppSettingStrings.mainAppSettingsBox);

  ReadingSettingsState() {
    _loadSettings();
  }

  late bool _arabicNameSurah;
  late bool _translationNameSurah;
  late bool _isArabicAyahShow;
  late bool _isTranslationAyahShow;
  late double _ayahArabicTextSize;
  late double _ayahTranslationTextSize;

  bool get arabicNameSurah => _arabicNameSurah;

  set arabicNameSurah(bool value) {
    if (_arabicNameSurah == value) return;
    _arabicNameSurah = value;
    _appSettingsBox.put(AppSettingStrings.keySurahArabicName, value);
    notifyListeners();
  }

  bool get translationNameSurah => _translationNameSurah;

  set translationNameSurah(bool value) {
    if (_translationNameSurah == value) return;
    _translationNameSurah = value;
    _appSettingsBox.put(AppSettingStrings.keyTranslationNameSurah, value);
    notifyListeners();
  }

  double get ayahArabicTextSize => _ayahArabicTextSize;

  set ayahArabicTextSize(double size) {
    if (_ayahArabicTextSize == size) return;
    _ayahArabicTextSize = size;
    _appSettingsBox.put(AppSettingStrings.keyAyahArabicTextSize, size);
    notifyListeners();
  }

  double get ayahTranslationTextSize => _ayahTranslationTextSize;

  set ayahTranslationTextSize(double size) {
    if (_ayahTranslationTextSize == size) return;
    _ayahTranslationTextSize = size;
    _appSettingsBox.put(AppSettingStrings.keyAyahTranslationTextSize, size);
    notifyListeners();
  }

  bool get isArabicAyahShow => _isArabicAyahShow;

  set isArabicAyahShow(bool state) {
    if (_isArabicAyahShow == state) return;

    if (!state && !_isTranslationAyahShow) {
      _isTranslationAyahShow = true;
      _appSettingsBox.put(AppSettingStrings.keyShowTranslationAyah, true);
    }

    _isArabicAyahShow = state;
    _appSettingsBox.put(AppSettingStrings.keyShowArabicAyah, state);
    notifyListeners();
  }

  bool get isTranslationAyahShow => _isTranslationAyahShow;

  set isTranslationAyahShow(bool state) {
    if (_isTranslationAyahShow == state) return;

    if (!state && !_isArabicAyahShow) {
      _isArabicAyahShow = true;
      _appSettingsBox.put(AppSettingStrings.keyShowArabicAyah, true);
    }

    _isTranslationAyahShow = state;
    _appSettingsBox.put(AppSettingStrings.keyShowTranslationAyah, state);
    notifyListeners();
  }

  void _loadSettings() {
    _arabicNameSurah = _appSettingsBox.get(AppSettingStrings.keySurahArabicName, defaultValue: true);
    _translationNameSurah = _appSettingsBox.get(AppSettingStrings.keyTranslationNameSurah, defaultValue: true);
    _isArabicAyahShow = _appSettingsBox.get(AppSettingStrings.keyShowArabicAyah, defaultValue: true);
    _isTranslationAyahShow = _appSettingsBox.get(AppSettingStrings.keyShowTranslationAyah, defaultValue: true);
    _ayahArabicTextSize = _appSettingsBox.get(AppSettingStrings.keyAyahArabicTextSize, defaultValue: AppConstants.defaultArabicTextSize);
    _ayahTranslationTextSize = _appSettingsBox.get(AppSettingStrings.keyAyahTranslationTextSize, defaultValue: AppConstants.defaultTranslationTextSize);
  }

  void reload() {
    _loadSettings();
    notifyListeners();
  }
}