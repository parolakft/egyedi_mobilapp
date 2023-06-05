// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/authentication/repository/datasource/registration_remote_data_source.dart';
import 'package:xy_mobil_app/authentication/repository/model/forgotten_pw_data.dart';

class RegistrationRepository {
  RegistrationRepository({
    required RegistrationRemoteDataSource registrationRemoteDataSource,
  }) : _registrationRemoteDataSource = registrationRemoteDataSource;

  final RegistrationRemoteDataSource _registrationRemoteDataSource;

  Future<void> register(String email, String password, String name) async {
    //TODO mi jön majd vissza?
    ForgottenPwData forgottenPwData =
        await _registrationRemoteDataSource.register(email, password, name);
  }

  // Future<void> getUser(String userId) async {
  //   final user = await _userRemoteDataSource.getUser(userId);
  //   _authenticationRepository.setUser(user);
  // }
}
