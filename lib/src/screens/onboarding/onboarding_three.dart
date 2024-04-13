import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
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
    return Consumer(builder: (_, ref, __) {
      final theme = ref.watch(themeProvider);
      return Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.7),
            child: LottieBuilder.asset(
              src.LottieProvider.onboardingTwoLottieAnim,
              height: 300.h,
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
                fontSize: 25.sp,
                color:
                    (theme == ThemeMode.dark) ? Colors.white : Colors.black87,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.25),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ).r,
              child: src.nunitoTextWidget(
                "Connect, learn, and thrive with a vibrant community. Let's conquer social media together!",
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                textAlign: TextAlign.center,
                color: (theme == ThemeMode.dark)
                    ? Colors.white
                    : Colors.black87.withOpacity(0.8),
              ),
            ),
          ),
        ],
      );
    });
  }
}
