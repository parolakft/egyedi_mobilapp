// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/authentication/repository/authentication_repository.dart';
import 'package:xy_mobil_app/authentication/repository/datasource/login_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/model/login_data.dart';

class LoginRepository {
  LoginRepository({
    required AuthenticationRepository authenticationRepository,
    required LoginRemoteDataSource loginRemoteDataSource,
  })  : _authenticationRepository = authenticationRepository,
        _loginRemoteDataSource = loginRemoteDataSource;

  final LoginRemoteDataSource _loginRemoteDataSource;
  final AuthenticationRepository _authenticationRepository;

  Future<void> login(String userId, String password) async {
    LoginData loginData = await _loginRemoteDataSource.login(userId, password);
    _authenticationRepository.setLoginData(loginData);
    _authenticationRepository.setUser(loginData.user);
  }

  // Future<void> getUser(String userId) async {
  //   final user = await _userRemoteDataSource.getUser(userId);
  //   _authenticationRepository.setUser(user);
  // }
}
