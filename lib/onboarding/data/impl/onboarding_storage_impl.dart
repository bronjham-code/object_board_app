import 'package:flutter/foundation.dart';
import 'package:object_board_app/onboarding/data/onboarding_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _showOnboardingKey = 'showOnboardingKey';

class OnboardingStorageImpl implements OnboardingStorage {
  OnboardingStorageImpl(this.sharedPreferences);

  @protected
  final SharedPreferences sharedPreferences;

  @override
  Future<void> dontShowAgain() => sharedPreferences.setBool(_showOnboardingKey, true);

  @override
  bool get hasShowOnboarding => sharedPreferences.getBool(_showOnboardingKey) != true;
}
