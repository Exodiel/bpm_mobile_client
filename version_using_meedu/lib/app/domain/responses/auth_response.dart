import 'package:google_maps/app/domain/models/user.dart';

class AuthResponse {
  final User? user;
  final String? accessToken;
  final int? expiresIn;

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.expiresIn,
  });
}
