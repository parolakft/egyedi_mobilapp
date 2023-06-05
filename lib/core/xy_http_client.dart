// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:xy_mobil_app/settings/repository/settings_repository.dart';

///
/// Saját HTTP kliens, ami IOClient-en alapul, tehát weben nem használható.
/// Az eredetitől az alábbiakban tér el:
/// - 10 mp connection timeout,
///
class XYHttpClient extends BaseClient {
  IOClient? _ioClient;
  final HttpClient _httpClient;

  XYHttpClient({
    required SettingsRepository settingsRepository,
  }) : _httpClient = HttpClient()
          ..connectionTimeout = const Duration(seconds: 10) {
    _ioClient = IOClient(_httpClient);
  }

  @override
  Future<IOStreamedResponse> send(BaseRequest request) async {
    if (_ioClient == null) {
      throw ClientException(
          'HTTP request failed. Client is already closed.', request.url);
    }
    return _ioClient!.send(request);
  }

  @override
  void close() {
    _ioClient?.close();
    _ioClient = null;
  }
}
