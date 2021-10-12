import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient {
  final FlutterSecureStorage _storage;

  AuthenticationClient(this._storage);

  Future<String?> get accessToken {
    return _storage.read(key: 'token');
  }

  Future<String?> get userId {
    return _storage.read(key: 'user');
  }

  Future<void> saveToken(String token) {
    return _storage.write(key: 'token', value: token);
  }

  Future<void> saveUserId(String userId) {
    return _storage.write(key: 'user', value: userId);
  }

  Future<void> delete() async {
    await _storage.delete(key: 'user');
    return _storage.delete(key: 'token');
  }
}