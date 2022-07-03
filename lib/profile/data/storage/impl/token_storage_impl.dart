import 'package:flutter/foundation.dart';
import 'package:object_board_app/profile/data/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = 'tokenKey';

class TokenStorageImpl implements TokenStorage {
  TokenStorageImpl(this.sharedPreferences);

  @protected
  final SharedPreferences sharedPreferences;

  @override
  bool get hasToken => sharedPreferences.getString(_tokenKey)?.isNotEmpty == true;

  @override
  Future<void> removeToken() => sharedPreferences.remove(_tokenKey);

  @override
  Future<void> setToken(String token) => sharedPreferences.setString(_tokenKey, token);

  @override
  String? get token => sharedPreferences.getString(_tokenKey);
}
