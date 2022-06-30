import 'package:simple_state/simple_state.dart';

class SplashGlobalState {
  final isInitialized = Observable(false);

  void onInitialized() => isInitialized.value = true;
}
