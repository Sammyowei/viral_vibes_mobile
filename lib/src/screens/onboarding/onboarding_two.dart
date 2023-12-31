import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viral_vibes_mobile/src/src.dart' as src;
import 'package:viral_vibes_mobile/src/widgets/widgets.dart';

class OnboardingTwo extends ConsumerStatefulWidget {
  const OnboardingTwo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends ConsumerState<OnboardingTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: const Alignment(0, -0.65),
          child: LottieBuilder.asset(
            src.LottieProvider.onboardingThreeLottieAnim,
            height: 300.h,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.05),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ).r,
            child: nunitoTextWidget(
              'Explore Powerful Tools ',
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.23),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ).r,
            child: nunitoTextWidget(
              "Step into a world of effortless social media mastery. Get ready to unleash your brand's potential!",
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              textAlign: TextAlign.center,
              color: Colors.black87.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
