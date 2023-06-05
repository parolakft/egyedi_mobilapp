// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:io';

import 'package:http/http.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';

///
/// A szerverhívások során keletkezett hibák átfordítása hibaüzenetekké
///
String mapExceptionToErrorMessage(Exception? exception) {
  if (exception == null) {
    return '';
  }
  if (exception is XYApiException) {
    // XY szerver által visszaadott hibák, amikor a status nem Bakery.OK
    // A hibaüzenet a szerver által visszaadott hibaüzenet
    // TODO hibaüzenetek kezelése
    return exception.status;
  }
  if (exception is ApiRequestException) {
    // HTTP hibák, amikor a HTTP status nem 200
    return 'Hiba történt a szerverrel való kommunikáció során, '
        'hibakód: ${exception.statusCode}';
  }
  if (exception is ClientException) {
    // elvileg a http.Client hibák így jönnek
    return 'Nem sikerült kapcsolódni a XY szerverhez!';
  }
  if (exception is SocketException) {
    // socket timeout esetén ez jön (nem elérhető a szerver)
    return 'Nem sikerült kapcsolódni a XY szerverhez!';
  }

  // fallback
  return 'Váratlan hiba történt az alkalmazásban!';
}
