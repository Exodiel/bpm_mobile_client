import 'package:flutter/widgets.dart' show FormState, GlobalKey;
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/repositories/authentication_repository.dart';

class LoginController extends SimpleNotifier {
  String _email = '', _password = '';
  final AuthenticationRepository _authenticationRepository = Get.i.find();

  final GlobalKey<FormState> formKey = GlobalKey();

  String get email => _email;
  String get password => _password;

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<bool> signIn() async {
    return _authenticationRepository.login(_email, _password);
  }
}