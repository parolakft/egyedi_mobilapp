// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/authentication/repository/datasource/authentication_local_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/model/login_data.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';

class AuthenticationRepository {
  AuthenticationRepository(
      {required AuthenticationLocalDataSource authenticationLocalDataSource})
      : _authenticationLocalDataSource = authenticationLocalDataSource,
        _loginData = const LoginData.empty(),
        _userId = authenticationLocalDataSource.getUserId(),
        _password = authenticationLocalDataSource.getPassword();

  LoginData _loginData;
  String _userId;
  String _password;

  final _controller = StreamController<User>();
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  Stream<User> get userStream async* {
//    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  LoginData get loginData => _loginData;
  String get userId => _userId;
  String get password => _password;

  bool get isUserStored => _userId.isNotEmpty && _password.isNotEmpty;

  void setLoginData(LoginData loginData) {
    _loginData = loginData;
  }

  void setStoredUserData(String userId, String password) {
    _storeUserData(userId, password);
  }

  void setUser(User user) {
    _controller.add(user);
  }

  void logout() {
    _clearStoredUserData();
    _loginData = const LoginData.empty();
    _controller.add(const User.empty());
  }

  void _storeUserData(String userId, String password) async {
    _userId = userId;
    _password = password;
    await _authenticationLocalDataSource.setUserId(_userId);
    await _authenticationLocalDataSource.setPassword(_password);
  }

  void _clearStoredUserData() async {
    _userId = '';
    _password = '';
    await _authenticationLocalDataSource.clearUserId();
    await _authenticationLocalDataSource.clearPassword();
  }

  void dispose() => _controller.close();
}
