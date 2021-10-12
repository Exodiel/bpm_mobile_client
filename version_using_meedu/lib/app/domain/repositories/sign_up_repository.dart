import 'package:google_maps/app/domain/inputs/sign_up.dart';

abstract class SignUpRepository {
  Future<bool> register(SignUpData data);
}