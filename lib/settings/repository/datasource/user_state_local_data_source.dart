// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:convert';

import 'package:xy_mobil_app/settings/repository/model/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userStatePrefix = 'USER_STATE_';

class UserStateLocalDataSource {
  final SharedPreferences _sharedPreferences;

  UserStateLocalDataSource({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  UserState getUserState(int userId) {
    final userStateString =
        _sharedPreferences.getString(userStatePrefix + '$userId');
    if (userStateString == null) {
      return const UserState.empty();
    }
    return UserState.fromJson(jsonDecode(userStateString));
  }

  void setUserState(int userId, UserState userState) {
    _sharedPreferences.setString(
      userStatePrefix + '$userId',
      jsonEncode(userState.toJson()),
    );
  }
}
