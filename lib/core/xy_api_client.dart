// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:xy_mobil_app/authentication/repository/authentication_repository.dart';
import 'package:xy_mobil_app/core/xy_http_client.dart';
import 'package:xy_mobil_app/settings/repository/settings_repository.dart';

class NoUrlException implements Exception {}

class ApiRequestException implements Exception {
  final int statusCode;

  ApiRequestException(this.statusCode);

  @override
  String toString() => 'ApiRequestException($statusCode)';
}

class XYApiException implements Exception {
  final String status;

  XYApiException(this.status);

  @override
  String toString() => 'XYApiException($status)';
}

/// API hívások közös dolgai
/// - timeout kezelés (nem, az nem itt van, hanem a service locatornál)
/// - fixen POST küldés, Content-Type: application/json-impl
/// - JWT Bearer token küldés, Authorization: Bearer <token>
/// - kérés JSON formázása:
///   {
///     "<paraméter_név>": <paraméter_érték>
///     "<paraméter_név>": <paraméter_érték>
///     ...
///   }
/// - válasz kinyerés:
///   {
///     "status": "<státusz>",
///     "<mezőnév>": "<mezőérték>",
///     "<mezőnév>": "<mezőérték>",
///     ...
///   }
/// - HTTP hibakódok fordítása saját értékekre
/// - <státusz> kiolvasása és átalakítása
///
class XYApiClient {
  final XYHttpClient _httpClient;
  final AuthenticationRepository _authenticationRepository;

  XYApiClient({
    required XYHttpClient httpClient,
    required SettingsRepository settingsRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _httpClient = httpClient,
        _authenticationRepository = authenticationRepository;

  Future<Map<String, dynamic>> callApi(String methodName,
      {Map<String, dynamic>? parameters}) async {
    const url = 'https://xyegyedidev1.intranet.parola.hu/api/egyedi/rest'; //XY

    final http.Response response = await _httpClient.post(
      Uri.parse(p.url.join(url, methodName)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + _authenticationRepository.loginData.token,
      },
      body: json.encode(parameters),
    );
    dev.log('URL:     ' + Uri.parse(p.url.join(url, methodName)).toString());
    dev.log('BODY:    ' + json.encode(parameters));
    dev.log('STATUS:  ' + response.statusCode.toString());
    if (response.statusCode != 200) {
      throw ApiRequestException(response.statusCode);
    }
    final Map<String, dynamic> bodyJson =
        jsonDecode(utf8.decode(response.bodyBytes));

    dev.log('RESP:    ' + bodyJson.toString());
    if (bodyJson['status'] != 'OK') {
      throw XYApiException(bodyJson['status']);
    }
    return bodyJson;
  }
}
