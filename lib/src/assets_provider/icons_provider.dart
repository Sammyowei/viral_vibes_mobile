const iconPath = "assets/icons";

extension IconExtention on String {
  String get png => '$iconPath/$this.png';

  String get jpg => '$iconPath/$this.jpg';

  String get svg => '$iconPath/$this.svg';
}

class IconProvider {
  static String user = 'user'.png;

  static String password = 'password'.png;

  static String hide = 'hide'.png;

  static String seen = 'seen'.png;
}
