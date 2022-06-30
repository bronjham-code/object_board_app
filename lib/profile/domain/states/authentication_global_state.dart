import 'package:simple_state/simple_state.dart';

class AuthenticationGlobalState {
  final isAuthenticated = Observable(false);

  void signIn() => isAuthenticated.value = true;

  void signOut() => isAuthenticated.value = false;
}
