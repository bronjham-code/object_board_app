import 'package:flutter/foundation.dart';
import 'package:object_board_app/onboarding/data/onboarding_storage.dart';
import 'package:object_board_app/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({required this.onboardingStorage});

  @protected
  final OnboardingStorage onboardingStorage;

  @override
  bool get hasShowOnboarding => onboardingStorage.hasShowOnboarding;

  @override
  Future<void> dontShowAgain() => onboardingStorage.dontShowAgain();
}
