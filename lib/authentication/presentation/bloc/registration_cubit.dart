// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:bloc/bloc.dart';
import 'package:xy_mobil_app/authentication/repository/registration_repository.dart';
import 'package:xy_mobil_app/core/api_state.dart';

class RegistrationCubit extends Cubit<ApiState<void>> {
  RegistrationCubit({required RegistrationRepository registrationRepository})
      : _registrationRepository = registrationRepository,
        super(const ApiState());

  final RegistrationRepository _registrationRepository;

  void register(String email, String password, String name) async {
    emit(const ApiState.loading());
    try {
      await _registrationRepository.register(email, password, name);
      emit(const ApiState.success(null));
    } on Exception catch (error) {
      emit(ApiState.failure(error));
    }
  }
}
