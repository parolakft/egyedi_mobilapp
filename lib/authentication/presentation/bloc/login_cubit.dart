// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:bloc/bloc.dart';
import 'package:xy_mobil_app/authentication/repository/login_repository.dart';
import 'package:xy_mobil_app/core/api_state.dart';

class LoginCubit extends Cubit<ApiState<void>> {
  LoginCubit({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(const ApiState());

  final LoginRepository _loginRepository;

  void login(String userId, String password) async {
    emit(const ApiState.loading());
    try {
      await _loginRepository.login(userId, password);
      emit(const ApiState.success(null));
    } on Exception catch (error) {
      emit(ApiState.failure(error));
    }
  }
}
