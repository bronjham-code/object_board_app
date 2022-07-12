import 'package:get_it/get_it.dart';
import 'package:object_board_app/core/extensions/get_it_extensions.dart';
import 'package:object_board_app/onboarding/data/impl/onboarding_storage_impl.dart';
import 'package:object_board_app/onboarding/data/onboarding_storage.dart';
import 'package:object_board_app/profile/data/storage/impl/token_storage_impl.dart';
import 'package:object_board_app/profile/data/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static Future<void> setupStorage() async {
    final getIt = GetIt.instance;
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt
      ..safeUnregister<TokenStorage>()
      ..registerLazySingleton<TokenStorage>(() => TokenStorageImpl(sharedPreferences))
      ..safeUnregister<OnboardingStorage>()
      ..registerLazySingleton<OnboardingStorage>(() => OnboardingStorageImpl(sharedPreferences));
  }

  static Future<void> clearAllData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.clear();
  }
}
