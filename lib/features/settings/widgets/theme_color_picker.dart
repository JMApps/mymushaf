import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_paddings.dart';
import '../../../l10n/app_localizations.dart';
import '../states/display_settings_state.dart';

class ThemeColorPicker extends StatelessWidget {
  const ThemeColorPicker({
    super.key,
    required this.color,
    required this.onChanged,
  });

  final Color color;
  final ValueChanged<ColorSwatch?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return ListTile(
      visualDensity: .comfortable,
      contentPadding: AppPaddings.hrMedium,
      title: Text(
        appLocale.themeColor,
      ),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              alignment: .center,
              actionsPadding: AppPaddings.medium,
              title: Text(appLocale.selectThemeColor),
              content: Material(
                color: Colors.transparent,
                child: MaterialColorPicker(
                  alignment: .center,
                  iconSelected: Icons.check_circle,
                  elevation: 0.5,
                  allowShades: false,
                  onMainColorChange: onChanged,
                  selectedColor: context.watch<DisplaySettingsState>().themeColor,
                ),
              ),
            ),
          );
        },
        icon: Icon(
          Icons.circle,
          color: color,
          size: 35,
        ),
      ),
    );
  }
}
