// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/authentication/repository/model/forgotten_pw_data.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';

class ForgottenPwRemoteDataSource {
  ForgottenPwRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<ForgottenPwData> lostPassword(String email) async {
    var forgottenPwData = ForgottenPwData.fromJson(await _apiClient
        .callApi('auth/lostPassword', parameters: {'email': email}));
    return forgottenPwData;
  }
}
