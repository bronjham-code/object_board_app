abstract class TokenStorage {
  String? get token;

  bool get hasToken;

  Future<void> setToken(String token);

  Future<void> removeToken();
}
