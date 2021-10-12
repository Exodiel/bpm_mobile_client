
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/data/providers/remote/authentication_api.dart';
import 'package:google_maps/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationClient _client;
  final AuthenticationAPI _authenticationAPI;
  AuthenticationRepositoryImpl(this._client, this._authenticationAPI);
  
  @override
  Future<String?> get accessToken => _client.accessToken;

  @override
  Future<String?> get userId => _client.userId;

  @override
  Future<bool> logOut() async {
    await _authenticationAPI.logOut();
    return true;
  }

  @override
  Future<bool> login(String email, String password) async {
    final data = await _authenticationAPI.login(email, password);

    if (data != null) {
      await _client.saveToken(data.accessToken!);
      await _client.saveUserId(data.user!.id.toString());
      return true;
    }
    return false;
  }

  
}