// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/profiledetails/repository/model/user_data.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<void> changePassword(String password, String newPassword) async {
    await _apiClient.callApi('mobile/changePassword',
        parameters: {'password': password, 'newPassword': newPassword});
  }

  Future<void> setAllergies(List<int> ids) async {
    await _apiClient.callApi('mobile/setAllergies', parameters: {'ids': ids});
  }

  Future<void> setBirthDate(String date) async {
    await _apiClient.callApi('mobile/setBirthDate', parameters: {'data': date});
  }

  Future<void> setGenderData(String gender) async {
    await _apiClient
        .callApi('mobile/setGenderData', parameters: {'data': gender});
  }

  Future<User> getUser() async {
    return UserData.fromJson(await _apiClient.callApi('mobile/getUser')).data;
  }
}
