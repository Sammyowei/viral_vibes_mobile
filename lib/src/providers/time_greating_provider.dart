import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final greetingStateNotifierProvider =
    StateNotifierProvider<TimeGreatingNotifier, String>((ref) {
  return TimeGreatingNotifier();
});

class TimeGreatingNotifier extends StateNotifier<String> {
  TimeGreatingNotifier() : super('');

  // Function to get greeting

  String getGreeting(int hour) {
    if (hour >= 6 && hour < 12) {
      return 'Good Morning ⛅';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon 🌞';
    } else {
      return 'Good Evening 🌙';
    }
  }

  // TODO: function to start checking the time

  void startCheckingTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      String greeting = getGreeting(now.hour);
      state = greeting;
    });
  }
}
