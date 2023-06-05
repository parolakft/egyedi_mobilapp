// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/info/repository/info_repository.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc({
    required InfoRepository infoRepository,
    required NavigationBloc appBloc,
  })  : _infoRepository = infoRepository,
        _appBloc = appBloc,
        super(const InfoState.initial()) {
    _handleAppState(_appBloc.state);
  }

  final InfoRepository _infoRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchInfo();
    }
  }

  Stream<InfoState> _fetchInfo() async* {
    yield state.copyWith(
      info: '',
    );
    try {
      final newInfo = await _infoRepository.getInfo();

      yield state.copyWith(
        info: newInfo,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        info: '',
      );
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is CategoryNavigationState) {
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
