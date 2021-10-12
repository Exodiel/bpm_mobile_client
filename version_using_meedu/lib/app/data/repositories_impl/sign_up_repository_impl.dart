import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/data/providers/remote/sign_up_api.dart';
import 'package:google_maps/app/domain/inputs/sign_up.dart';
import 'package:google_maps/app/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final AuthenticationClient _client;
  final SignUpAPI _signAPI;

  SignUpRepositoryImpl(this._client, this._signAPI);


  @override
  Future<bool> register(SignUpData data) async {
    final response = await _signAPI.register(data);

    if (response != null) {
      await _client.saveToken(response.accessToken!);
      await _client.saveUserId(response.user!.id.toString());
      return true;
    }
    return false;
  }

}