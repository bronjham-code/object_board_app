abstract class AuthenticationRepository {
  bool get isAuthenticated;

  Future<void> signIn();

  Future<void> signOut();
}
