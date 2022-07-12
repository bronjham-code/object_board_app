import 'package:flutter/material.dart';
import 'package:object_board_app/onboarding/presentation/onboarding_view.dart';

class SecondOnboardingStep extends StatelessWidget {
  const SecondOnboardingStep({
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
          child: const Text('Next'),
        ),
        const SizedBox(height: onboardingBottomOffset),
      ],
    );
  }
}
