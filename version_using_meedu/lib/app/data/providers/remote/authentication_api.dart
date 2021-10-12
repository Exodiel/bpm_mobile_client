import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps/app/domain/models/user.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/domain/responses/auth_response.dart';

class AuthenticationAPI {
  final Dio _dio;
  final AuthenticationClient _authenticationClient;

  AuthenticationAPI(this._dio, this._authenticationClient);

  Future<AuthResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://192.168.0.103:8000/api/v1/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final Map<String, dynamic> data = response.data;
      return AuthResponse(
        user: User.fromJson(data['user']),
        accessToken: data['accessToken'],
        expiresIn: data['expiresIn'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> logOut() async {
    try {
      await _authenticationClient.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
