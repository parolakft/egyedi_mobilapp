// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc logger
///
/// Kiírja konzolra a bloc(ok) összes állapotváltozását és hibaállapotát.
/// Érdemes csak debug build esetén használni (kDebugMode == 1)
class LoggingBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    // ignore: avoid_print
    dev.log('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   // ignore: avoid_print
  //   dev.log('${bloc.runtimeType} $transition');
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onChange(BlocBase bloc, Change change) {
    // ignore: avoid_print
    dev.log('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}
