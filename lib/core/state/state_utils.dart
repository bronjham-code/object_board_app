import 'package:get_it/get_it.dart';
import 'package:object_board_app/onboarding/domain/states/onboarding_global_state.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';

class StateUtils {
  static Future<Iterable<Object>> createStates() async {
    final getIt = GetIt.instance;

    return [
      AuthenticationGlobalState(authenticationRepository: getIt.get()),
      OnboardingGlobalState(onboardingRepository: getIt.get()),
    ];
  }
}
