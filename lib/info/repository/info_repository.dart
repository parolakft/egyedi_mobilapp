// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/info/repository/datasource/info_remote_data_source.dart';
import 'package:xy_mobil_app/info/repository/model/info_data.dart';

class InfoRepository {
  InfoRepository({
    required InfoRemoteDataSource infoRemoteDataSource,
  }) : _infoRemoteDataSource = infoRemoteDataSource;

  final InfoRemoteDataSource _infoRemoteDataSource;

  Future<String> getInfo() async {
    InfoData infoData = await _infoRemoteDataSource.getInfo();
    return infoData.data;
  }
}
