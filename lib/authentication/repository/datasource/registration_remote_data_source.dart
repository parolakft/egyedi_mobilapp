// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/authentication/repository/model/forgotten_pw_data.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';

class RegistrationRemoteDataSource {
  RegistrationRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<ForgottenPwData> register(
      String email, String password, String name) async {
    var forgottenPwData = ForgottenPwData.fromJson(await _apiClient.callApi(
        'auth/register',
        parameters: {'email': email, 'password': password, 'name': name}));
    return forgottenPwData;
  }
}
