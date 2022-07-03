import 'package:flutter/foundation.dart';
import 'package:object_board_app/profile/data/storage/token_storage.dart';
import 'package:object_board_app/profile/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this.tokenStorage);

  @protected
  final TokenStorage tokenStorage;

  @override
  bool get isAuthenticated => tokenStorage.hasToken;

  @override
  Future<void> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    tokenStorage.setToken('fakeToken');
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    tokenStorage.removeToken();
  }
}
