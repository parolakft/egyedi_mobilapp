// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/authentication/repository/datasource/forgotten_pw_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/model/forgotten_pw_data.dart';

class ForgottenPwRepository {
  ForgottenPwRepository({
    required ForgottenPwRemoteDataSource forgottenPwRemoteDataSource,
  }) : _forgottenPwRemoteDataSource = forgottenPwRemoteDataSource;

  final ForgottenPwRemoteDataSource _forgottenPwRemoteDataSource;

  Future<void> lostPassword(String email) async {
    ForgottenPwData forgottenPwData =
        await _forgottenPwRemoteDataSource.lostPassword(email);
  }

  // Future<void> getUser(String userId) async {
  //   final user = await _userRemoteDataSource.getUser(userId);
  //   _authenticationRepository.setUser(user);
  // }
}
