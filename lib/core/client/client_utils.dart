import 'package:get_it/get_it.dart';

class ClientUtils {
  static Future<void> setupClients() async {
    final getIt = GetIt.instance;

    // getIt
    //   ..safeUnregister<AuthenticationRepository>()
    //   ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getIt.get()));
  }
}
