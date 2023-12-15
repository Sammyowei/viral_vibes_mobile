import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:viral_vibes_mobile/src/src.dart' as src;

class OnboardingThree extends ConsumerStatefulWidget {
  const OnboardingThree({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingThreeState();
}

class _OnboardingThreeState extends ConsumerState<OnboardingThree> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, -0.7),
          child: LottieBuilder.asset(
            src.LottieProvider.onboardingTwoLottieAnim,
            height: 300,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.05),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: src.nunitoTextWidget(
              'Join our Social Circle.',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.23),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: src.nunitoTextWidget(
              "Connect, learn, and thrive with a vibrant community. Let's conquer social media together!",
              fontWeight: FontWeight.w600,
              fontSize: 16,
              textAlign: TextAlign.center,
              color: Colors.black87.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
