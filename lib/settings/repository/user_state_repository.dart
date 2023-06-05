// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/settings/repository/datasource/user_state_local_data_source.dart';
import 'package:xy_mobil_app/settings/repository/model/user_state.dart';

class UserStateRepository {
  UserStateRepository(
      {required UserStateLocalDataSource userStateLocalDataSource})
      : _userStateLocalDataSource = userStateLocalDataSource;

  final UserStateLocalDataSource _userStateLocalDataSource;

  UserState getUserState(int userId) =>
      _userStateLocalDataSource.getUserState(userId);

  // void setUserState(int userId, UserState userState) =>
  //     _userStateLocalDataSource.setUserState(userId, userState);

  void setCurrentPartnerId(int userId, int lastUsedPartnerId) =>
      _userStateLocalDataSource.setUserState(
        userId,
        _userStateLocalDataSource
            .getUserState(userId)
            .copyWith(lastUsedPartnerId: lastUsedPartnerId),
      );
}
