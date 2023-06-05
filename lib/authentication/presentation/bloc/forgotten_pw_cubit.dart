// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:bloc/bloc.dart';
import 'package:xy_mobil_app/authentication/repository/forgotten_pw_repository.dart';
import 'package:xy_mobil_app/core/api_state.dart';

class ForgottenPwCubit extends Cubit<ApiState<void>> {
  ForgottenPwCubit({required ForgottenPwRepository forgottenPwRepository})
      : _forgottenPwRepository = forgottenPwRepository,
        super(const ApiState());

  final ForgottenPwRepository _forgottenPwRepository;

  void lostPassword(String email) async {
    emit(const ApiState.loading());
    try {
      await _forgottenPwRepository.lostPassword(email);
      emit(const ApiState.success(null));
    } on Exception catch (error) {
      emit(ApiState.failure(error));
    }
  }
}
