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

  static String userSvg = 'user'.svg;

  static String homeSvg = 'home'.svg;

  static String shoppingBag = 'shopping-bag'.svg;

  static String wallet = 'wallet'.svg;

  static String instaIcon = 'instagram'.png;

  static String linkedInIcon = 'linkedin'.png;

  static String facebookIcon = 'facebook'.png;

  static String spotifyIcon = 'spotify'.png;

  static String telegramIcon = 'telegram'.png;

  static String youtubeIcon = 'youtube'.png;

  static String twitterIcon = 'twitter'.png;

  static String tiktokIcon = 'tik-tok'.png;

  static String threadSvgIcon = 'threads'.svg;

  static String verifiedIcon = 'verify'.png;

  static String faceIdIcon = 'face-id'.png;

  static String fingerPrintIcon = 'fingerprint'.png;

  static String googleIcon = 'google'.png;

  static String discordIcon = 'discord'.png;

  static String snapChatIcon = 'snap'.png;

  static String twitchIcon = 'twitch'.png;

  static String websiteIcon = 'web'.png;

  static String reviewsIcon = 'review'.png;

  static String othersIcon = 'other'.png;

  static String everythingIcon = 'everything'.png;

  static String threadIcon = 'threads'.png;

  static String money = 'money'.png;
}
