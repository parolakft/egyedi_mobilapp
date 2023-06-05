// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/settings/repository/datasource/settings_local_data_source.dart';

class SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  final _controller = StreamController<String>();

  SettingsRepository({required SettingsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  Stream<String> get connectionIdStream async* {
    yield* _controller.stream;
  }

//  Settings get settings => Settings(connectionId: connectionId);

  String get connectionId => _localDataSource.getConnectionId();

  void dispose() => _controller.close();
}
