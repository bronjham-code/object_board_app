import 'package:flutter/foundation.dart';
import 'package:object_board_app/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:simple_state/simple_state.dart';

const onboardingInitStep = 1;
const onboardingTotalSteps = 3;

class OnboardingGlobalState {
  OnboardingGlobalState({required this.onboardingRepository});

  @protected
  final OnboardingRepository onboardingRepository;

  late final hasShowOnboarding = Observable(onboardingRepository.hasShowOnboarding);

  late final currentStep = Observable(onboardingInitStep);

  Future<void> dontShowAgain() => onboardingRepository.dontShowAgain();

  void close() => hasShowOnboarding.value = false;

  void back() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void next() {
    if (currentStep.value < onboardingTotalSteps) {
      currentStep.value++;
    }
  }
}
