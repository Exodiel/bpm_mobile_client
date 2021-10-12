
abstract class AuthenticationRepository {
  Future<String?> get accessToken;
  Future<String?> get userId;
  Future<bool> logOut();
  Future<bool> login(
    String email,
    String password,
  );
}