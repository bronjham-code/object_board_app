import 'package:flutter/material.dart';
import 'package:object_board_app/splash/domain/states/splash_global_state.dart';
import 'package:provider/provider.dart';

class ApplicationUtils {
  static Future<void> setup(BuildContext context) async {
    final splashState = Provider.of<SplashGlobalState>(context, listen: false);
    await Future.delayed(const Duration(seconds: 3));
    splashState.onInitialized();
  }
}
