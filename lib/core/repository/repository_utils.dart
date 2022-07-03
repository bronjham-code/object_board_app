import 'package:get_it/get_it.dart';
import 'package:object_board_app/core/extensions/get_it_extensions.dart';
import 'package:object_board_app/profile/domain/repositories/authentication_repository.dart';
import 'package:object_board_app/profile/domain/repositories/impl/authentication_repository_impl.dart';

class RepositoryUtils {
  static Future<void> setupRepositories() async {
    final getIt = GetIt.instance;

    getIt
      ..safeUnregister<AuthenticationRepository>()
      ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getIt.get()));
  }
}
