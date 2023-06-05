// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:convert';

import 'package:xy_mobil_app/settings/repository/model/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userSettingsPrefix = 'USER_SETTINGS_';

class UserSettingsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  UserSettingsLocalDataSource({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  UserSettings getUserSettings(int userId) {
    final userSettingsString =
        _sharedPreferences.getString(userSettingsPrefix + '$userId');
    if (userSettingsString == null) {
      return const UserSettings.empty();
    }
    return UserSettings.fromJson(jsonDecode(userSettingsString));
  }

  void setUserSettings(int userId, UserSettings userSettings) {
    _sharedPreferences.setString(
      userSettingsPrefix + '$userId',
      jsonEncode(userSettings.toJson()),
    );
  }
}
