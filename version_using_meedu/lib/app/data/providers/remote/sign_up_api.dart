import 'package:dio/dio.dart';
import 'package:google_maps/app/domain/inputs/sign_up.dart';
import 'package:google_maps/app/domain/models/user.dart';
import 'package:google_maps/app/domain/responses/auth_response.dart';

class SignUpAPI {
  final Dio _dio;
  SignUpAPI(this._dio);

  Future<AuthResponse?> register(SignUpData data) async {
    try {
      final response = await _dio.post(
        'http://192.168.0.103:8000/api/v1/auth/register',
        data: {
          'email': data.email,
          'password': data.password,
          'name': data.name,
          'rol': data.rol,
          'type': data.type,
        },
      );
      final Map<String, dynamic> dataResponse = response.data;
      return AuthResponse(
        user: User.fromJson(dataResponse['user']),
        accessToken: dataResponse['accessToken'],
        expiresIn: dataResponse['expiresIn'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }
}
