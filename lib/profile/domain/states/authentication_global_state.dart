import 'package:flutter/foundation.dart';
import 'package:object_board_app/profile/domain/repositories/authentication_repository.dart';
import 'package:simple_state/simple_state.dart';

class AuthenticationGlobalState {
  AuthenticationGlobalState({required this.authenticationRepository});

  @protected
  final AuthenticationRepository authenticationRepository;

  late final isAuthenticated = Observable(authenticationRepository.isAuthenticated);

  final isSigning = Observable(false);

  Future<void> signIn() async {
    isSigning.value = true;
    try {
      await authenticationRepository.signIn();
      isAuthenticated.value = true;
    } finally {
      isSigning.value = false;
    }
  }

  Future<void> signOut() async {
    isSigning.value = true;
    try {
      await authenticationRepository.signOut();
      isAuthenticated.value = false;
    } finally {
      isSigning.value = false;
    }
  }
}
