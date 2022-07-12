abstract class OnboardingRepository {
  bool get hasShowOnboarding;

  Future<void> dontShowAgain();
}
