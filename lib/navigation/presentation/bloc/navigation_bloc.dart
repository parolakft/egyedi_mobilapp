// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/authentication/repository/authentication_repository.dart';
import 'package:xy_mobil_app/authentication/repository/login_repository.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';
import 'package:xy_mobil_app/navigation/repository/model/error.dart';

//import 'package:xy_mobil_app/tlog/tlog.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

/// Fő alkalmazás navigációs logika bloc-a
///
/// Figyeli
/// - az alkalmazás állapotát (beállítások, bejelentkezési állapot) a
/// konstruktorban kapott bloc-ok és repositoryk figyelésével,
/// valamint
/// - a felhasználói kéréseket (rendelés szerkesztése, beállítások
/// szerkesztése stb.) a bejövő események figyelésével,
/// és ezek alapján eldönti, hogy milyen állapotba kell
/// navigálni (NavigationState)
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    required AuthenticationRepository authenticationRepository,
    required LoginRepository loginRepository,
    //required TLog tlog,
  })  : _authenticationRepository = authenticationRepository,
        _loginRepository = loginRepository,
        //_tlog = tlog,
        super(SplashNavigationState()) {
    _userSubscription = _authenticationRepository.userStream.listen((user) {
      add(UserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final LoginRepository _loginRepository;
  //final TLog _tlog;

  StreamSubscription<String>? _connectionIdSubscription;
  StreamSubscription<User>? _userSubscription;

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ApplicationOpened) {
      //_tlog.move(''); // elvileg '' a kezdőérték is...
      yield SplashNavigationState();
      yield LoginNavigationState();
    } else if (event is PagePopped) {
      final currentState = state;
      if (currentState is ForgottenPwNavigationState) {
        yield LoginNavigationState();
      } else if (currentState is RegistrationNavigationState) {
        yield LoginNavigationState();
      } else if (currentState is ProfileNavigationState) {
        yield CategoryNavigationState.copy(state: currentState);
      } else if (currentState is ItemDetailsNavigationState) {
        yield CategoryNavigationState.copy(state: currentState);
      }
    } else if (event is UserChanged) {
      if (event.user.isEmpty && state is AuthenticatedNavigationState) {
        // ha unauthenticated jött és védendő oldalon vagyunk, akkor login page
        yield LoginNavigationState();
      } else if (!event.user.isEmpty) {
        // ha authenticated, akkor az állapotból ellenőrizni, hogy hova megyünk
        // (pl. van szerkesztés alatt rendelés, akkor oda
        //_tlog.move('MOBRE1');
        yield CategoryNavigationState.initial(user: event.user);
      }
    } else if (event is ForgottenPwRequested) {
      final currentState = state;
      if (currentState is LoginNavigationState) {
        yield ForgottenPwNavigationState();
      }
    } else if (event is RegistrationRequested) {
      final currentState = state;
      if (currentState is LoginNavigationState) {
        yield RegistrationNavigationState();
      }
    } else if (event is ProfileRequested) {
      final currentState = state;
      if (currentState is CategoryNavigationState) {
        yield ProfileNavigationState.copyFromBase(state: currentState);
      }
    } else if (event is CategoryRequested) {
      final currentState = state;
      if (currentState is ItemDetailsNavigationState) {
        yield CategoryNavigationState.copy(state: currentState);
      }
    } else if (event is ItemDetailsRequested) {
      final currentState = state;
      if (currentState is CategoryNavigationState) {
        yield ItemDetailsNavigationState.copyFromBase(
            state: currentState, item: event.item);
      }
    }
  }

  @override
  Future<void> close() {
    _connectionIdSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }
}
