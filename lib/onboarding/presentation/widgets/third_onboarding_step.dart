import 'package:flutter/material.dart';
import 'package:object_board_app/onboarding/presentation/onboarding_view.dart';

class ThirdOnboardingStep extends StatelessWidget {
  const ThirdOnboardingStep({
    super.key,
    required this.onClose,
  });

  @protected
  final VoidCallback onClose;

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
          onPressed: onClose,
          child: const Text('Finish'),
        ),
        const SizedBox(height: onboardingBottomOffset),
      ],
    );
  }
}
