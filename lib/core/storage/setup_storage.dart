import 'package:get_it/get_it.dart';
import 'package:object_board_app/profile/data/storage/impl/token_storage_impl.dart';
import 'package:object_board_app/profile/data/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static Future<void> setupStorage() async {
    final getIt = GetIt.instance;
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<TokenStorage>(() => TokenStorageImpl(sharedPreferences));
  }
}
