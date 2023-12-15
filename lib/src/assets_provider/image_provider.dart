const imagePath = 'assets/images';

extension ImageExtention on String {
  String get png => '$imagePath/$this.png';
  String get svg => '$imagePath/$this.svg';
  String get jpg => '$imagePath/$this.jpg';
}

class ImageProvider {
  static final onboardingOneImage = 'onboarding-one'.png;
  static final onboardingTwoImage = 'onboarding-two'.png;
  static final onboardingThreeImage = 'onboarding-three'.png;
  static final authScreenBackImg = 'auth-page'.jpg;
  static final authScreenImg = 'auth-page-2'.jpg;
}
