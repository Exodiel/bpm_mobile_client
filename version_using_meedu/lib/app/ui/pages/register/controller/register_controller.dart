import 'package:google_maps/app/domain/inputs/sign_up.dart';
import 'package:google_maps/app/domain/repositories/sign_up_repository.dart';
import 'package:google_maps/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> registerFormKey = GlobalKey();
  final SignUpRepository _signUpRepository = Get.i.find();

  Future<bool> submit() async {
    final response = await _signUpRepository.register(
      SignUpData(
        name: state.name,
        rol: 'client',
        type: 'client',
        email: state.email,
        password: state.password,
      ),
    );
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
