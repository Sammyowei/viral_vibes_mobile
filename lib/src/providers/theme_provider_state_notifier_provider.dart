import 'package:flutter/material.dart' show ThemeMode;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

  void toggleTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    await prefs.setBool('isDark', isDark);
  }

  Future<void> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
