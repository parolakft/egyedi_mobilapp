// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:shared_preferences/shared_preferences.dart';

const connectionIdSetting = 'CONNECTION_ID_SETTING';
const urlSetting = 'URL_SETTING';

class SettingsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  SettingsLocalDataSource({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  String getConnectionId() =>
      _sharedPreferences.getString(connectionIdSetting) ?? '';
  Future<void> setConnectionId(String connectionId) =>
      _sharedPreferences.setString(connectionIdSetting, connectionId);

  // URL nem perzisztens
  // String getUrl() => _sharedPreferences.getString(URL_SETTING) ?? '';
  // Future<void> setUrl(String url) =>
  //     _sharedPreferences.setString(URL_SETTING, url);
  // Future<void> clearUrl() => _sharedPreferences.remove(URL_SETTING);
}
