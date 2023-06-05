// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/profiledetails/repository/datasource/profile_remote_data_source.dart';

class ProfileRepository {
  ProfileRepository({
    required ProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  final ProfileRemoteDataSource _profileRemoteDataSource;

  Future<void> changePassword(String password, String newPassword) async {
    await _profileRemoteDataSource.changePassword(password, newPassword);
  }

  Future<void> setAllergies(List<int> ids) async {
    await _profileRemoteDataSource.setAllergies(ids);
  }

  Future<void> setBirthDate(String date) async {
    await _profileRemoteDataSource.setBirthDate(date);
  }

  Future<void> setGenderData(String gender) async {
    await _profileRemoteDataSource.setGenderData(gender);
  }

  Future<User> getUser() async {
    return await _profileRemoteDataSource.getUser();
  }

  // Future<void> getUser(String userId) async {
  //   final user = await _userRemoteDataSource.getUser(userId);
  //   _authenticationRepository.setUser(user);
  // }
}
