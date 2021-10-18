import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thitsarparami/settings/theme.dart';

class Preferences {
  //
  static SharedPreferences? preferences;
  // ignore: constant_identifier_names
  static const String KEY_SELECTED_THEME = 'key_selected_theme';

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(AppTheme selectedTheme) async {
    //selectedTheme ??= AppTheme.light;
    String theme = jsonEncode(selectedTheme.toString());
    preferences!.setString(KEY_SELECTED_THEME, theme);
  }

  static AppTheme? getTheme() {
    String? theme = preferences!.getString(KEY_SELECTED_THEME);
    if (null == theme) {
      return AppTheme.light;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static AppTheme? getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
