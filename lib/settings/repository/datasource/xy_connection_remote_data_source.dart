// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/core/xy_api_client.dart';

class XYConnectionRemoteDataSource {
  final XYApiClient _apiClient;

  XYConnectionRemoteDataSource({required XYApiClient apiClient})
      : _apiClient = apiClient;

  Future<void> testConnection() async {
    await _apiClient.callApi('testConnection');
  }
}
