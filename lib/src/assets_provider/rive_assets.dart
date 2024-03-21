const rivePath = "assets/rive";

extension RiveExtention on String {
  String get riv => '$rivePath/$this.riv';
}

class RiveAsset {
  static String loadingIndicator = 'loading_indicator'.riv;

  static String loadingAnimation = 'loading_animation'.riv;
}
