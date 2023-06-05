// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/settings/repository/model/user_settings.dart';
import 'package:xy_mobil_app/settings/repository/user_settings_repository.dart';

part 'user_settings_state.dart';
part 'user_settings_event.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final UserSettingsRepository _userSettingsRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;

  UserSettingsBloc({
    required UserSettingsRepository userSettingsRepository,
    required NavigationBloc appBloc,
  })  : _userSettingsRepository = userSettingsRepository,
        _appBloc = appBloc,
        super(const UserSettingsState()) {
    _handleAppState(_appBloc.state);
    _appBlocSubscription =
        _appBloc.stream.listen((appState) => _handleAppState(appState));
    add(VersionRequested());
  }

  @override
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is UserChanged) {
      UserSettings userSettings =
          _userSettingsRepository.getUserSettings(event.user.id);
      yield state.copyWith(
        userId: event.user.id,
        isStornoVisible: userSettings.isStornoVisible,
      );
    } else if (event is IsStornoVisibleChanged) {
      if (state.userId > 0) {
        _userSettingsRepository.setIsStornoVisible(
            state.userId, event.isStornoVisible);
      }
      yield state.copyWith(
        isStornoVisible: event.isStornoVisible,
      );
    } else if (event is VersionRequested) {
      final packageInfo = await PackageInfo.fromPlatform();
      yield state.copyWith(appVersion: packageInfo.version);
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is AuthenticatedNavigationState &&
        appState.user.id != state.userId) {
      add(UserChanged(appState.user));
    }
  }

  @override
  Future<void> close() {
    _appBlocSubscription?.cancel();
    return super.close();
  }
}
