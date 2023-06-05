// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:shared_preferences/shared_preferences.dart';

const userIdKey = 'USER_ID';
const userPasswordKey = 'USER_PASSWORD';

class AuthenticationLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthenticationLocalDataSource({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  String getUserId() => _sharedPreferences.getString(userIdKey) ?? '';
  String getPassword() => _sharedPreferences.getString(userPasswordKey) ?? '';

  Future<bool> setUserId(String userId) =>
      _sharedPreferences.setString(userIdKey, userId);

  Future<bool> setPassword(String password) =>
      _sharedPreferences.setString(userPasswordKey, password);

  Future<bool> clearUserId() => _sharedPreferences.remove(userIdKey);

  Future<bool> clearPassword() => _sharedPreferences.remove(userPasswordKey);
}
