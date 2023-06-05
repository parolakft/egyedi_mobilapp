// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/info/repository/datasource/privacy_remote_data_source.dart';
import 'package:xy_mobil_app/info/repository/model/info_data.dart';

class PrivacyRepository {
  PrivacyRepository({
    required PrivacyRemoteDataSource privacyRemoteDataSource,
  }) : _privacyRemoteDataSource = privacyRemoteDataSource;

  final PrivacyRemoteDataSource _privacyRemoteDataSource;

  Future<String> getPrivacy() async {
    InfoData infoData = await _privacyRemoteDataSource.getPrivacy();
    return infoData.data;
  }
}
