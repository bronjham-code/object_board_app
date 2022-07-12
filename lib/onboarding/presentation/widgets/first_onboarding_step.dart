import 'package:flutter/material.dart';
import 'package:object_board_app/onboarding/presentation/onboarding_view.dart';

class FirstOnboardingStep extends StatelessWidget {
  const FirstOnboardingStep({
    super.key,
    required this.onNext,
  });

  @protected
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(runtimeType.toString()),
          ),
        ),
        ElevatedButton(
          onPressed: onNext,
          child: const Text('Start'),
        ),
        const SizedBox(height: onboardingBottomOffset),
      ],
    );
  }
}
