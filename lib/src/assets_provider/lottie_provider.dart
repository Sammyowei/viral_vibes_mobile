const lottieFilePath = 'assets/lottie';

extension LottieExtention on String {
  String get lottie => '$lottieFilePath/$this.json';
}

class LottieProvider {
  static String onboardingOneLottieAnim = 'onboarding-one-lottie'.lottie;
  static String onboardingTwoLottieAnim = 'onboarding-two-lottie'.lottie;
  static String onboardingThreeLottieAnim = 'onboarding-three-lottie'.lottie;
  static String loadingAnim = 'animation'.lottie;
}
