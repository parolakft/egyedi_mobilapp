// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/authentication/repository/model/login_data.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';

class LoginRemoteDataSource {
  LoginRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<LoginData> login(String userId, String password) async {
    var loginData = LoginData.fromJson(await _apiClient.callApi('auth/login',
        parameters: {'email': userId, 'password': password}));
    return loginData;
  }
}
