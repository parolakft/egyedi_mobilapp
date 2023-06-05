// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/core/api_state.dart';
import 'package:xy_mobil_app/settings/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(SettingsState(
          connectionId: settingsRepository.connectionId,
          state: null,
        ));
}
