// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:bloc/bloc.dart';
import 'package:xy_mobil_app/authentication/repository/authentication_repository.dart';
import 'package:xy_mobil_app/core/api_state.dart';

class LogoutCubit extends Cubit<ApiState<void>> {
  LogoutCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ApiState());

  final AuthenticationRepository _authenticationRepository;

  void logout() async {
    emit(const ApiState.loading());
    try {
      _authenticationRepository.logout();
      emit(const ApiState.success(null));
    } on Exception catch (error) {
      emit(ApiState.failure(error));
    }
  }
}
