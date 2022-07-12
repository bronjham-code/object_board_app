import 'dart:async';

import 'package:flutter/material.dart';
import 'package:object_board_app/core/const/style_const.dart';
import 'package:object_board_app/onboarding/domain/states/onboarding_global_state.dart';
import 'package:object_board_app/onboarding/presentation/widgets/first_onboarding_step.dart';
import 'package:object_board_app/onboarding/presentation/widgets/second_onboarding_step.dart';
import 'package:object_board_app/onboarding/presentation/widgets/third_onboarding_step.dart';
import 'package:provider/provider.dart';
import 'package:simple_state/simple_state.dart';

const onboardingBottomOffset = 36.0;

class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final Reaction _stepChangeReaction;

  late final OnboardingGlobalState _onboardingGlobalState;

  void _onControllerIndexChanged() {
    final controllerStep = _tabController.index + 1;
    final currentStep = _onboardingGlobalState.currentStep;
    if (controllerStep < currentStep.value) {
      while (controllerStep != currentStep.value) {
        _onboardingGlobalState.back();
      }
    } else if (controllerStep > currentStep.value) {
      while (controllerStep != currentStep.value) {
        _onboardingGlobalState.next();
      }
    }
  }

  Future<void> _onClose() async {
    await _onboardingGlobalState.dontShowAgain();
    _onboardingGlobalState.close();
  }

  void _onNext() => _onboardingGlobalState.next();

  Widget _buildSteps() => TabBarView(
        controller: _tabController,
        children: [
          FirstOnboardingStep(onNext: _onNext),
          SecondOnboardingStep(onNext: _onNext),
          ThirdOnboardingStep(onClose: _onClose),
        ],
      );

  Widget _buildIndicator() => Positioned(
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.all(StyleConst.kSizePadding12),
          child: TabPageSelector(
            controller: _tabController,
          ),
        ),
      );

  Widget _buildCloseButton() => Positioned(
        top: MediaQuery.of(context).viewPadding.top,
        right: StyleConst.kSizePadding12,
        child: IconButton(
          onPressed: _onClose,
          icon: const Icon(Icons.close),
        ),
      );

  @override
  void initState() {
    _onboardingGlobalState = Provider.of(context, listen: false);
    final currentStep = _onboardingGlobalState.currentStep;
    _tabController = TabController(
      length: onboardingTotalSteps,
      vsync: this,
      initialIndex: currentStep.value - 1,
    )..addListener(_onControllerIndexChanged);
    _stepChangeReaction = Reaction.when(
      listenables: [currentStep],
      condition: () => currentStep.value != (_tabController.index + 1) && !_tabController.indexIsChanging,
      reaction: () => _tabController.animateTo(currentStep.value - 1),
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _stepChangeReaction.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      listenables: [_onboardingGlobalState.hasShowOnboarding],
      builder: (_) {
        if (!_onboardingGlobalState.hasShowOnboarding.value) {
          return widget.child;
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                _buildSteps(),
                _buildIndicator(),
                _buildCloseButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
