import 'package:flutter/material.dart';
import 'package:viral_vibes_mobile/src/palette/palette.dart';

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.tetiaryColor,
      onTertiary: Palette.tetiaryColor,
      error: Palette.errorColor,
      onError: Palette.errorColor,
      tertiary: Palette.tetiaryColor,
      onPrimary: Palette.primaryBackgroundColor,
      primary: Palette.primaryBackgroundColor,
      secondary: Palette.secondaryBackgroundColor,
      onSecondary: Palette.secondaryBackgroundColor,
      background: Palette.primaryBackgroundColor,
      onBackground: Palette.primaryBackgroundColor,
      brightness: Brightness.light,
    ),
  );
}
