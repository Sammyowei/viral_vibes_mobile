import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final otpCountDownTimeStateNotifierProvider =
    StateNotifierProvider<CountDownTimerNotifier, int>((ref) {
  return CountDownTimerNotifier(30);
});

class CountDownTimerNotifier extends StateNotifier<int> {
  late Timer _timer;
  CountDownTimerNotifier(int initialValue) : super(initialValue);

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state > 0) {
          state = state - 1;
        } else {
          _timer.cancel();
          state = state;
        }
      },
    );
  }

  void resetTimer(int seconds) {
    _timer.cancel();
    state = seconds;
  }

  int get countDownValue => state;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
