// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/info/repository/privacy_repository.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';

part 'privacy_event.dart';
part 'privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc({
    required PrivacyRepository privacyRepository,
    required NavigationBloc appBloc,
  })  : _privacyRepository = privacyRepository,
        _appBloc = appBloc,
        super(const PrivacyState.initial()) {
    _handleAppState(_appBloc.state);
  }

  final PrivacyRepository _privacyRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<PrivacyState> mapEventToState(
    PrivacyEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchInfo();
    }
  }

  Stream<PrivacyState> _fetchInfo() async* {
    yield state.copyWith(
      privacy: '',
    );
    try {
      final newPrivacy = await _privacyRepository.getPrivacy();

      yield state.copyWith(
        privacy: newPrivacy,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        privacy: '',
      );
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is ProfileNavigationState) {
      add(NavigationRefreshRequested());
    }
  }

  @override
  Future<void> close() {
    _userSettingsSubscription?.cancel();
    _appBlocSubscription?.cancel();
    return super.close();
  }
}
