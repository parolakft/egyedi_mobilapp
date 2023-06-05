// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xy_mobil_app/bloc_observer.dart';
import 'package:xy_mobil_app/navigation/presentation/ui/app.dart';
import 'package:xy_mobil_app/injection_container.dart' as di;
import 'package:intl/date_symbol_data_local.dart'; //for date locale

/// Az alkalmazás fő belépési pontja
///
/// Az alkamazás által használt könyvtárakat inicializálja,
/// majd elindítja az App fő widgetet.
void main() async {
  // async main miatt először ezt kell meghívni és megvárni
  WidgetsFlutterBinding.ensureInitialized();
  // service locator inizializálás, innentől lehet sl()-t használni
  await di.init();
  // Dátum lokalizálás
  await initializeDateFormatting('hu_HU');
  // Összes bloc állapotváltozásainak kiírása a konzolra, csak debug build
  // esetén
  if (kDebugMode) {
    Bloc.observer = LoggingBlocObserver();
  }
// Csak álló orientáció!
  // @see https://stackoverflow.com/q/49418332
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // HydratedBloc tároló inicializálás
/*
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
 */
  // alkalmazás futtatása
  runApp(const App());
}
