import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:mymushaf/core/constants/app_setting_strings.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


class DisplaySettingsState extends ChangeNotifier {
  final Box<dynamic> _appSettingsBox = Hive.box(AppSettingStrings.mainAppSettingsBox);

  DisplaySettingsState() {
    _loadSettings();
  }

  int _appThemeModeIndex = 0;
  int get appThemeModeIndex => _appThemeModeIndex;

  set appThemeModeIndex(int value) {
    if (_appThemeModeIndex == value) return;
    _appThemeModeIndex = value;
    _appSettingsBox.put(AppSettingStrings.keyAppThemeModeIndex, value);
    notifyListeners();
  }

  ThemeMode get appThemeMode {
    switch (_appThemeModeIndex) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  bool _displayAlwaysOn = true;
  bool get displayAlwaysOn => _displayAlwaysOn;

  Future<void> setDisplayAlwaysOn(bool value) async {
    if (_displayAlwaysOn == value) return;

    _displayAlwaysOn = value;
    unawaited(WakelockPlus.toggle(enable: value));
    unawaited(_appSettingsBox.put(AppSettingStrings.keyAlwaysDisplayOn, value));
    notifyListeners();
  }

  Color _themeColor = Colors.brown;
  Color get themeColor => _themeColor;

  set themeColor(Color color) {
    if (_themeColor == color) return;
    _themeColor = color;
    _appSettingsBox.put(AppSettingStrings.keyAppThemeColor, color.toARGB32());
    notifyListeners();
  }

  void _loadSettings() {
    _displayAlwaysOn = _appSettingsBox.get(
      AppSettingStrings.keyAlwaysDisplayOn,
      defaultValue: true,
    );

    unawaited(WakelockPlus.toggle(enable: _displayAlwaysOn));

    _themeColor = Color(
      _appSettingsBox.get(
        AppSettingStrings.keyAppThemeColor,
        defaultValue: Colors.brown.toARGB32(),
      ),
    );

    _appThemeModeIndex = _appSettingsBox.get(
      AppSettingStrings.keyAppThemeModeIndex,
      defaultValue: 0,
    );
  }

  void reload() {
    _loadSettings();
    notifyListeners();
  }
}