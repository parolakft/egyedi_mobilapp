// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/settings/repository/datasource/user_settings_local_data_source.dart';
import 'package:xy_mobil_app/settings/repository/model/user_settings.dart';

class UserSettingsRepository {
  UserSettingsRepository(
      {required UserSettingsLocalDataSource userSettingsLocalDataSource})
      : _userSettingsLocalDataSource = userSettingsLocalDataSource;

  final UserSettingsLocalDataSource _userSettingsLocalDataSource;

  UserSettings getUserSettings(int userId) =>
      _userSettingsLocalDataSource.getUserSettings(userId);

  void setIsStornoVisible(int userId, bool isStornoVisible) =>
      _userSettingsLocalDataSource.setUserSettings(
        userId,
        _userSettingsLocalDataSource
            .getUserSettings(userId)
            .copyWith(isStornoVisible: isStornoVisible),
      );
}
