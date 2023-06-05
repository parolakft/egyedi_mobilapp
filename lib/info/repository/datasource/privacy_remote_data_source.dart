// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/info/repository/model/info_data.dart';

class PrivacyRemoteDataSource {
  PrivacyRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<InfoData> getPrivacy() async {
    var infoData =
        InfoData.fromJson(await _apiClient.callApi('mobile/getPrivacy'));
    return infoData;
  }
}
