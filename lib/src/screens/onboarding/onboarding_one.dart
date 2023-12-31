import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:viral_vibes_mobile/src/src.dart' as src;
import 'package:viral_vibes_mobile/src/widgets/widgets.dart';

class OnboardingOne extends ConsumerStatefulWidget {
  const OnboardingOne({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends ConsumerState<OnboardingOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment(0, -1),
          child: LottieBuilder.asset(
            src.LottieProvider.onboardingOneLottieAnim,
            height: 300.h,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.05),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ).w,
            child: nunitoTextWidget(
              'Welcome to Viral Vibes.',
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 1 - ScreenUtil().setHeight(0.7)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ).w,
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
