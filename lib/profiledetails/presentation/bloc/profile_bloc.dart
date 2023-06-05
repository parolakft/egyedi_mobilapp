// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/allergens/repository/allergens_repository.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/profiledetails/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AllergensRepository allergensRepository,
    required ProfileRepository profileRepository,
    required NavigationBloc appBloc,
  })  : _allergensRepository = allergensRepository,
        _profileRepository = profileRepository,
        _appBloc = appBloc,
        super(ProfileState.initial(
            (appBloc.state as ProfileNavigationState).user, const [])) {
    _handleAppState(_appBloc.state);
  }

  final AllergensRepository _allergensRepository;
  final ProfileRepository _profileRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _getUser(event.user);
    } else if (event is GenderChangeRequested) {
      yield* setGenderData(event.gender);
    } else if (event is BirthDateChangeRequested) {
      yield* setBirthDate(event.date);
    } else if (event is AllergiesChangeRequested) {
      yield* setAllergies();
    } else if (event is PasswordChangeRequested) {
      yield* changePassword(event.password, event.newPassword);
    }
  }

  Stream<ProfileState> _getUser(User user) async* {
    try {
      User user = await _profileRepository.getUser();
      final List<Allergen> allergensList =
          await _allergensRepository.allergens();
      List allergens = [];
      for (var i = 0; i < allergensList.length; i++) {
        allergens.add({
          "id": allergensList[i].id,
          "name": allergensList[i].name,
          "active": user.allergies.contains(allergensList[i]),
        });
      }
      yield state.copyWith(
        user: user,
        allergensList: allergens,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        user: user,
        allergensList: [],
      );
    }
  }

  Stream<ProfileState> setGenderData(String gender) async* {
    try {
      await _profileRepository.setGenderData(gender);
      User user = await _profileRepository.getUser();
      yield state.copyWith(
        user: user,
      );
    } on Exception catch (error) {
      yield state;
    }
  }

  Stream<ProfileState> setBirthDate(String date) async* {
    try {
      await _profileRepository.setBirthDate(date);
      User user = await _profileRepository.getUser();
      yield state.copyWith(
        user: user,
      );
    } on Exception catch (error) {
      yield state;
    }
  }

  Stream<ProfileState> setAllergies() async* {
    List<int> ids = [];
    for (var i = 0; i < state.allergensList.length; i++) {
      if (state.allergensList[i]['active']) {
        ids.add(state.allergensList[i]['id']);
      }
    }
    try {
      await _profileRepository.setAllergies(ids);
      User user = await _profileRepository.getUser();
      yield state.copyWith(
        user: user,
      );
    } on Exception catch (error) {
      yield state;
    }
  }

  Stream<ProfileState> changePassword(
      String password, String newPassword) async* {
    try {
      await _profileRepository.changePassword(password, newPassword);
      User user = await _profileRepository.getUser();
      yield state.copyWith(
        user: user,
      );
    } on Exception catch (error) {
      yield state;
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is ProfileNavigationState) {
      add(NavigationRefreshRequested(appState.user));
    }
  }

  @override
  Future<void> close() {
    _userSettingsSubscription?.cancel();
    _appBlocSubscription?.cancel();
    return super.close();
  }
}
