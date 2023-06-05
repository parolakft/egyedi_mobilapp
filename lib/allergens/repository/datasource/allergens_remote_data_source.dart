// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/allergens/repository/model/allergens_data.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';

class AllergensRemoteDataSource {
  AllergensRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<AllergensData> allergens() async {
    var infoData =
        AllergensData.fromJson(await _apiClient.callApi('mobile/allergens'));
    return infoData;
  }
}
