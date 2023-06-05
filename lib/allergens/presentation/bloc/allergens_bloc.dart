// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/allergens/repository/allergens_repository.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';

part 'allergens_event.dart';
part 'allergens_state.dart';

class AllergensBloc extends Bloc<AllergensEvent, AllergensState> {
  AllergensBloc({
    required AllergensRepository allergensRepository,
    required NavigationBloc appBloc,
  })  : _allergensRepository = allergensRepository,
        _appBloc = appBloc,
        super(const AllergensState.initial()) {
    _handleAppState(_appBloc.state);
  }

  final AllergensRepository _allergensRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<AllergensState> mapEventToState(
    AllergensEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchList();
    }
  }

  Stream<AllergensState> _fetchList() async* {
    yield state.copyWith(
      allergensList: [],
    );
    try {
      final List<Allergen> allergensList =
          await _allergensRepository.allergens();

      yield state.copyWith(
        allergensList: allergensList,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        allergensList: [],
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
